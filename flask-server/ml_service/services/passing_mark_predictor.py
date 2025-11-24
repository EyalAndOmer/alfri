"""Passing mark prediction service.

Handles predictions for grade distributions using Keras models.
"""
from typing import Dict, List, Any, Optional, Union
import math

from flask import current_app

from .base_prediction_service import PredictionService
from ..errors import ValidationError

DEFAULT_GRADE_LABELS = ["A", "B", "C", "D", "E", "F"]


class PassingMarkPredictor(PredictionService):
    """Handles passing mark distribution predictions using Keras models.
    
    This service uses neural network models to predict the probability distribution
    across different grade categories for a given subject and student features.
    """
    
    def __init__(self, registry, validator):
        """Initialize the passing mark predictor.
        
        Args:
            registry: Model registry containing loaded models
            validator: Subject input validator instance
        """
        super().__init__(registry, validator)
        self._numpy = self._try_import_numpy()
    
    def _try_import_numpy(self):
        """Attempt to import numpy, return None if unavailable.
        
        Returns:
            numpy module if available, None otherwise
        """
        try:
            import numpy as np
            return np
        except Exception:
            return None
    
    def predict_mark_distribution(self, subject: str, features: List) -> Dict[str, Any]:
        """Predict grade distribution for a subject.
        
        Args:
            subject: Subject name
            features: List of feature values
            
        Returns:
            Dictionary containing subject, distribution, and chosen grade
            
        Raises:
            ValidationError: If validation fails
        """
        # Validate subject
        self.validator.validate({"subject": subject})
        
        # Validate features type
        if not isinstance(features, (list, tuple)):
            raise ValidationError("Invalid features: expected a list of numeric values")
        
        # Get model
        model = self.registry.get_mark_model(subject)
        if model is None:
            raise ValidationError(f"No mark model for subject '{subject}'")
        
        # Get metadata
        metadata = self.get_model_metadata(subject, "mark")
        expected_len = metadata.get("expected_input_len")
        grade_labels = metadata.get("grade_labels")
        
        # Validate feature length
        if expected_len is not None and len(features) != int(expected_len):
            raise ValidationError(f"Invalid feature length: expected {expected_len}, got {len(features)}")
        
        # Prepare input
        X = self._prepare_input_features(features)
        
        # Make prediction with thread safety
        predictions = self._predict_with_lock(model, X, subject)
        
        # Interpret predictions into distribution
        distribution = self._interpret_predictions(predictions)
        
        # Get labels and normalize
        labels = self._get_grade_labels(len(distribution), grade_labels)
        normalized_probs = self._normalize_distribution(distribution)
        
        # Find best grade
        chosen_idx = self._get_max_index(normalized_probs)
        
        return {
            "subject": subject,
            "distribution": {label: prob for label, prob in zip(labels, normalized_probs)},
            "chosenGrade": labels[chosen_idx]
        }
    
    def _prepare_input_features(self, features: List) -> Union[List, Any]:
        """Convert features to appropriate format (numpy array or list).
        
        Args:
            features: List of feature values
            
        Returns:
            Numpy array if numpy available, nested list otherwise
            
        Raises:
            ValidationError: If features cannot be converted to numeric
        """
        try:
            X_vals = [float(x) for x in features]
            if self._numpy is not None:
                return self._numpy.asarray(X_vals, dtype=self._numpy.float32).reshape(1, -1)
            return [X_vals]
        except Exception:
            raise ValidationError("features must be numeric")
    
    def _predict_with_lock(self, model, X, subject: str):
        """Execute model prediction with optional thread-safety lock.
        
        Args:
            model: Trained model
            X: Input features
            subject: Subject name (for logging)
            
        Returns:
            Model predictions
            
        Raises:
            Exception: If prediction fails
        """
        lock = getattr(self.registry, "keras_predict_lock", None)
        try:
            if lock:
                with lock:
                    return self._call_model_predict(model, X)
            return self._call_model_predict(model, X)
        except Exception as exc:
            current_app.logger.exception("Mark prediction failed for %s: %s", subject, exc)
            raise
    
    def _call_model_predict(self, model, X):
        """Call appropriate predict method on model.
        
        Args:
            model: Model instance
            X: Input features
            
        Returns:
            Model predictions
        """
        if hasattr(model, "predict"):
            return model.predict(X)
        if hasattr(model, "predict_proba"):
            return model.predict_proba(X)
        return model(X)
    
    def _interpret_predictions(self, predictions) -> List[float]:
        """Interpret model predictions into a probability distribution.
        
        Args:
            predictions: Raw model output
            
        Returns:
            List of probabilities
        """
        if self._numpy is not None:
            return self._interpret_with_numpy(predictions)
        return self._interpret_without_numpy(predictions)
    
    def _interpret_with_numpy(self, predictions) -> List[float]:
        """Interpret predictions using numpy.
        
        Args:
            predictions: Raw model output
            
        Returns:
            List of probabilities
            
        Raises:
            ValueError: If prediction shape is unexpected
        """
        arr = self._numpy.asarray(predictions)
        
        if arr.ndim == 0:
            return self._scalar_to_distribution_numpy(float(arr))
        elif arr.ndim == 1:
            return self._normalize_vector_numpy(arr)
        elif arr.ndim == 2:
            return self._normalize_vector_numpy(arr[0])
        else:
            raise ValueError("Unexpected prediction shape")
    
    def _scalar_to_distribution_numpy(self, score: float) -> List[float]:
        """Convert scalar prediction to distribution using numpy.
        
        Args:
            score: Single prediction value
            
        Returns:
            Probability distribution with one-hot encoding
        """
        score = max(0.0, min(1.0, score))
        n = len(DEFAULT_GRADE_LABELS)
        bins = self._numpy.linspace(0.0, 1.0, n + 1)
        probs = self._numpy.zeros(n, dtype=self._numpy.float32)
        idx = int(self._numpy.searchsorted(bins, score, side="right") - 1)
        idx = max(0, min(n - 1, idx))
        probs[idx] = 1.0
        return probs.astype(float).tolist()
    
    def _normalize_vector_numpy(self, vector) -> List[float]:
        """Normalize vector to probability distribution using numpy.
        
        Args:
            vector: Raw probability or logit vector
            
        Returns:
            Normalized probability distribution
        """
        v = vector.astype(float)
        s = float(v.sum())
        
        if s <= 0.0 or (v < 0).any():
            # Apply softmax
            ex = self._numpy.exp(v - v.max())
            return (ex / float(ex.sum())).astype(float).tolist()
        
        return (v / s).astype(float).tolist()
    
    def _interpret_without_numpy(self, predictions) -> List[float]:
        """Interpret predictions without numpy (pure Python).
        
        Args:
            predictions: Raw model output
            
        Returns:
            List of probabilities
            
        Raises:
            ValueError: If prediction type is unexpected
        """
        if isinstance(predictions, (int, float)):
            return self._scalar_to_distribution_python(float(predictions))
        elif isinstance(predictions, (list, tuple)):
            return self._normalize_vector_python(predictions)
        else:
            raise ValueError("Unexpected prediction type without numpy")
    
    def _scalar_to_distribution_python(self, score: float) -> List[float]:
        """Convert scalar prediction to distribution using pure Python.
        
        Args:
            score: Single prediction value
            
        Returns:
            Probability distribution with one-hot encoding
        """
        score = max(0.0, min(1.0, score))
        n = len(DEFAULT_GRADE_LABELS)
        bin_size = 1.0 / n
        idx = int(min(n - 1, int(score / bin_size)))
        probs = [0.0] * n
        probs[idx] = 1.0
        return probs
    
    def _normalize_vector_python(self, predictions) -> List[float]:
        """Normalize vector to probability distribution using pure Python.
        
        Args:
            predictions: Raw probability or logit vector
            
        Returns:
            Normalized probability distribution
        """
        # Flatten nested lists
        if len(predictions) == 1 and isinstance(predictions[0], (list, tuple)):
            row = [float(x) for x in predictions[0]]
        else:
            row = [float(x) for x in predictions]
        
        s = sum(row)
        if s <= 0.0 or any(x < 0 for x in row):
            # Apply softmax
            m = max(row) if row else 0.0
            ex = [math.exp(x - m) for x in row]
            s2 = sum(ex) if sum(ex) > 0.0 else 1.0
            return [e / s2 for e in ex]
        
        return [x / s for x in row]
    
    def _get_grade_labels(self, n_classes: int, custom_labels: Optional[List]) -> List[str]:
        """Get grade labels for distribution.
        
        Args:
            n_classes: Number of grade classes
            custom_labels: Optional custom label list
            
        Returns:
            List of grade labels
        """
        if isinstance(custom_labels, (list, tuple)) and len(custom_labels) == n_classes:
            return list(custom_labels)
        
        # Fallback to default labels
        if n_classes <= len(DEFAULT_GRADE_LABELS):
            return DEFAULT_GRADE_LABELS[:n_classes]
        
        # Extend with generic names
        return DEFAULT_GRADE_LABELS + [f"G{i}" for i in range(n_classes - len(DEFAULT_GRADE_LABELS))]
    
    def _normalize_distribution(self, distribution: List[float]) -> List[float]:
        """Ensure distribution sums to 1.0.
        
        Args:
            distribution: Raw probability distribution
            
        Returns:
            Normalized distribution summing to 1.0
        """
        if self._numpy is not None:
            total = float(self._numpy.sum(distribution))
            n_classes = len(distribution)
            if total <= 0.0:
                return [float(self._numpy.float64(1.0 / n_classes)) for _ in range(n_classes)]
            return [float(x) / total for x in distribution]
        
        total = float(sum(distribution))
        n_classes = len(distribution)
        if total <= 0.0:
            return [1.0 / n_classes for _ in range(n_classes)]
        return [float(x) / total for x in distribution]
    
    def _get_max_index(self, probabilities: List[float]) -> int:
        """Find index of maximum probability.
        
        Args:
            probabilities: List of probability values
            
        Returns:
            Index of the maximum value
        """
        if self._numpy is not None:
            return int(self._numpy.argmax(probabilities))
        return max(range(len(probabilities)), key=lambda i: probabilities[i])

