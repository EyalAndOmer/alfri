"""Prediction endpoints

Provides the batch POST /api/v1/predictions/passing-chance endpoint which uses
loaded logistic chance models to return passing probabilities.
"""
from flask import Blueprint, request, current_app, jsonify

from ..validation import SubjectInputValidator
from ..errors import ModelNotLoadedError, ValidationError
import math

DEFAULT_GRADE_LABELS = ["A", "B", "C", "D", "E", "F"]

predict_bp = Blueprint("predict", __name__)


# New endpoint: batch passing-chance predictions using logistic models
@predict_bp.route("/api/v1/predictions/passing-chance", methods=["POST"])
def predict_passing_chance():
    """Accepts JSON {"subjects": {"subj1": [features], "subj2": [features], ...}}

    For each subject:
    - validate subject string
    - ensure model registry is present
    - find chance model for the subject; if missing, record a skipped entry with status 422
    - validate feature vector length against MODEL_MAP metadata expected_input_len when provided
    - use model.predict_proba to compute probability for the positive class
    - return numeric probability (0..1 float) and percentage string with two decimals

    Response JSON shape:
    {"results": {"subj1": {"probability": 0.12, "percentage": "12.00%"},
                 "subj2": {"status": 422, "error": "model_missing", "message": "..."}}}
    """
    payload = request.get_json(silent=True)
    if not isinstance(payload, dict):
        raise ValidationError("Invalid payload: expected JSON object with 'subjects' mapping")

    subjects_map = payload.get("subjects")
    if not isinstance(subjects_map, dict):
        raise ValidationError("Missing or invalid 'subjects' field; expected mapping of subject->feature list")

    registry = current_app.config.get("MODEL_REGISTRY")
    if registry is None:
        # models haven't been loaded into config; treat as service not available
        raise ModelNotLoadedError("Model registry not available")

    results = {}
    validator = SubjectInputValidator(min_len=1, max_len=128)

    # helper to find expected_input_len from registry.model_map
    model_map = getattr(registry, "model_map", {}) or {}

    for subj, features in subjects_map.items():
        # default error container will be placed into results on continue
        try:
            # validate subject string
            validator.validate({"subject": subj})
        except ValidationError as vex:
            results[subj] = {"status": 422, "error": "INVALID_SUBJECT", "message": vex.message}
            continue
        except Exception as exc:
            # other unexpected validation issue
            results[subj] = {"status": 422, "error": "INVALID_SUBJECT", "message": str(exc)}
            continue

        model = registry.get_chance_model(subj)
        if model is None:
            # gracefully skip missing models with 422 status per-subject
            results[subj] = {"status": 422, "error": "MODEL_MISSING", "message": f"No chance model for subject '{subj}'"}
            continue

        # get expected_input_len if present in model_map metadata
        expected_len = None
        for name, meta in (model_map.items() if isinstance(model_map, dict) else []):
            if (meta or {}).get("role") == "chance" and (meta or {}).get("subject") == subj:
                expected_len = (meta or {}).get("expected_input_len")
                break

        # validate features type
        if not isinstance(features, (list, tuple)):
            results[subj] = {"status": 422, "error": "INVALID_FEATURES", "message": "features must be a list of numeric values"}
            continue

        if expected_len is not None and len(features) != int(expected_len):
            results[subj] = {"status": 422, "error": "INVALID_FEATURE_LENGTH", "message": f"expected length {expected_len}, got {len(features)}"}
            continue

        # coerce features to floats
        try:
            X = [float(x) for x in features]
        except Exception:
            results[subj] = {"status": 422, "error": "INVALID_FEATURE_VALUES", "message": "features must be numeric"}
            continue

        # compute probability using logistic model's predict_proba when available
        try:
            if hasattr(model, "predict_proba"):
                probs = model.predict_proba([X])
                # probs is array-like shape (n_samples, n_classes)
                try:
                    # prefer probability of class 1 if available
                    p = float(probs[0][1]) if len(probs[0]) >= 2 else float(probs[0][-1])
                except Exception:
                    # fallback: try converting first value
                    p = float(probs[0][0])
            elif hasattr(model, "predict"):
                # fallback: use predict, map label to 0.0/1.0
                lab = model.predict([X])[0]
                try:
                    p = 1.0 if int(lab) else 0.0
                except Exception:
                    p = 1.0 if lab else 0.0
            else:
                results[subj] = {"status": 500, "error": "MODEL_NO_PREDICT", "message": "Model has no predict or predict_proba method"}
                continue
        except Exception as exc:
            results[subj] = {"status": 500, "error": "PREDICTION_FAILED", "message": str(exc)}
            continue

        # clamp probability to [0,1] and format
        try:
            if p < 0.0:
                p = 0.0
            elif p > 1.0:
                p = 1.0
        except Exception:
            p = float(p)

        results[subj] = {"probability": float(p), "percentage": f"{float(p) * 100:.2f}%"}

    return jsonify({"results": results}), 200


@predict_bp.route("/api/v1/predictions/passing-mark", methods=["POST"])
def predict_passing_mark():
    """Predict passing mark distribution using a Keras model.

    Expected JSON payload: {"subject": "math101", "features": [f1, f2, ...]}

    Behavior:
    - Validate payload and subject string
    - Ensure model registry present and that a 'mark' model for the subject exists
    - Validate feature vector length against MODEL_MAP metadata expected_input_len when available
    - Use Keras model.predict to obtain either a vector of scores/probabilities
      or a single continuous value. If vector, interpret as class probabilities
      for discrete grades. If continuous (single value), return a distribution
      by mapping the value into grade buckets (not ideal; prefer vector outputs).
    - Normalize distribution so probabilities sum to ~1.0 and select the grade
      with highest probability as `chosen_grade`.

    Thread-safety: Keras backends may not be safe for concurrent .predict calls.
    This endpoint will attempt to use `MODEL_REGISTRY.keras_predict_lock` (a
    threading.Lock provided by the registry) to serialize predict calls when
    present. The use of that lock is documented here and in the registry.

    Response JSON shape:
    {"subject": "math101", "distribution": {"A": 0.1, "B": 0.9}, "chosen_grade": "B"}
    """
    payload = request.get_json(silent=True)
    if not isinstance(payload, dict):
        raise ValidationError("Invalid payload: expected JSON object with 'subject' and 'features'")

    subject = payload.get("subject")
    features = payload.get("features")

    validator = SubjectInputValidator(min_len=1, max_len=128)
    try:
        validator.validate({"subject": subject})
    except ValidationError as vex:
        raise

    if not isinstance(features, (list, tuple)):
        raise ValidationError("Invalid features: expected a list of numeric values")

    registry = current_app.config.get("MODEL_REGISTRY")
    if registry is None:
        raise ModelNotLoadedError("Model registry not available")

    model = registry.get_mark_model(subject)
    if model is None:
        raise ValidationError(f"No mark model for subject '{subject}'")

    # Find expected_input_len and grade_labels from the registry.model_map if available
    model_map = getattr(registry, "model_map", {}) or {}
    expected_len = None
    grade_labels = None
    for name, meta in (model_map.items() if isinstance(model_map, dict) else []):
        if (meta or {}).get("role") == "mark" and (meta or {}).get("subject") == subject:
            expected_len = (meta or {}).get("expected_input_len")
            grade_labels = (meta or {}).get("grade_labels")
            break

    if expected_len is not None and len(features) != int(expected_len):
        raise ValidationError(f"Invalid feature length: expected {expected_len}, got {len(features)}")

    # Try to import numpy, but gracefully fall back to pure-Python math
    try:
        import numpy as _np  # type: ignore
    except Exception:
        _np = None

    try:
        # build X as nested list when numpy is unavailable, else as ndarray
        X_vals = [float(x) for x in features]
        if _np is not None:
            X = _np.asarray(X_vals, dtype=_np.float32).reshape(1, -1)
        else:
            X = [X_vals]
    except Exception:
        raise ValidationError("features must be numeric")

    # perform predict under registry keras lock when available
    lock = getattr(registry, "keras_predict_lock", None)
    try:
        if lock:
            with lock:
                preds = _predict_with_model(model, X)
        else:
            preds = _predict_with_model(model, X)
    except Exception as exc:
        current_app.logger.exception("Mark prediction failed for %s: %s", subject, exc)
        raise

    # Interpret predictions: preds may be a scalar, 1-d array, or 2-d array
    dist = None
    try:
        if _np is not None:
            arr = _np.asarray(preds)
            if arr.ndim == 0:
                score = float(arr)
                score = max(0.0, min(1.0, score))
                n = len(DEFAULT_GRADE_LABELS)
                bins = _np.linspace(0.0, 1.0, n + 1)
                probs = _np.zeros(n, dtype=_np.float32)
                idx = int(_np.searchsorted(bins, score, side="right") - 1)
                idx = max(0, min(n - 1, idx))
                probs[idx] = 1.0
                dist = probs.astype(float)
            elif arr.ndim == 1:
                v = arr.astype(float)
                s = float(v.sum())
                if s <= 0.0:
                    ex = _np.exp(v - v.max())
                    probs = ex / float(ex.sum())
                else:
                    if (v < 0).any():
                        ex = _np.exp(v - v.max())
                        probs = ex / float(ex.sum())
                    else:
                        probs = v / s
                dist = probs.astype(float)
            elif arr.ndim == 2:
                row = arr[0].astype(float)
                s = float(row.sum())
                if s <= 0.0 or (row < 0).any():
                    ex = _np.exp(row - row.max())
                    probs = ex / float(ex.sum())
                else:
                    probs = row / s
                dist = probs.astype(float)
            else:
                raise ValueError("Unexpected prediction shape")
        else:
            # numpy unavailable: operate on Python scalars/lists
            if isinstance(preds, (int, float)):
                score = float(preds)
                score = max(0.0, min(1.0, score))
                n = len(DEFAULT_GRADE_LABELS)
                # uniform bins
                bin_size = 1.0 / n
                idx = int(min(n - 1, int(score / bin_size)))
                probs = [0.0] * n
                probs[int(idx)] = 1.0
                dist = probs
            elif isinstance(preds, (list, tuple)):
                # flatten nested lists
                if len(preds) == 1 and isinstance(preds[0], (list, tuple)):
                    row = [float(x) for x in preds[0]]
                else:
                    row = [float(x) for x in preds]
                s = sum(row)
                if s <= 0.0 or any(x < 0 for x in row):
                    # softmax
                    m = max(row) if row else 0.0
                    ex = [math.exp(x - m) for x in row]
                    s2 = sum(ex) if sum(ex) > 0.0 else 1.0
                    probs = [e / s2 for e in ex]
                else:
                    probs = [x / s for x in row]
                dist = probs
            else:
                raise ValueError("Unexpected prediction type without numpy")
    except Exception as exc:
        current_app.logger.exception("Failed to interpret model output: %s", exc)
        raise

    # Determine labels for distribution
    n_classes = int(len(dist))
    labels = None
    if isinstance(grade_labels, (list, tuple)) and len(grade_labels) == n_classes:
        labels = list(grade_labels)
    else:
        # fallback: use default grade labels truncated/extended to n_classes
        if n_classes <= len(DEFAULT_GRADE_LABELS):
            labels = DEFAULT_GRADE_LABELS[:n_classes]
        else:
            # extend with generic names G0, G1...
            labels = DEFAULT_GRADE_LABELS + [f"G{i}" for i in range(n_classes - len(DEFAULT_GRADE_LABELS))]

    # normalize to sum to 1.0 defensively
    if _np is not None:
        total = float(_np.sum(dist))
        if total <= 0.0:
            probs_norm = [float(_np.float64(1.0 / n_classes)) for _ in range(n_classes)]
        else:
            probs_norm = [float(x) / total for x in dist]
        chosen_idx = int(_np.argmax(probs_norm))
    else:
        total = float(sum(dist))
        if total <= 0.0:
            probs_norm = [1.0 / n_classes for _ in range(n_classes)]
        else:
            probs_norm = [float(x) / total for x in dist]
        # argmax
        chosen_idx = max(range(len(probs_norm)), key=lambda i: probs_norm[i])

    distribution = {label: prob for label, prob in zip(labels, probs_norm)}
    chosen_grade = labels[int(chosen_idx)]

    return jsonify({"subject": subject, "distribution": distribution, "chosen_grade": chosen_grade}), 200


def _predict_with_model(model, X):
    """Helper to call model.predict or predict_proba and return a numpy array."""
    # prefer predict (Keras) which returns arrays; if predict_proba exists, use it
    if hasattr(model, "predict"):
        return model.predict(X)
    if hasattr(model, "predict_proba"):
        return model.predict_proba(X)
    # last-resort: try call as a function
    return model(X)
