"""Clustering endpoints

Provides:
- POST /api/v1/clustering/similar-subjects

Payload: {"focusVectors": [[...], [...], ...], "studyProgramId": "...", "n_clusters": optional int}

Returns JSON: {"cluster_indices": [0,1,1,...], "centroid": [...], "offset_applied": 0}

Simple pure-Python kmeans implementation is used to avoid adding heavy dependencies.
"""
from flask import Blueprint, request, jsonify
import math
import random

clustering_bp = Blueprint("clustering", __name__)


def _validate_numeric_vector(v):
    if not isinstance(v, (list, tuple)):
        return False
    if len(v) == 0:
        return False
    for x in v:
        try:
            float(x)
        except Exception:
            return False
    return True


def _mean_vector(vectors):
    # assumes non-empty and consistent lengths
    n = len(vectors)
    m = len(vectors[0])
    out = [0.0] * m
    for vec in vectors:
        for i, val in enumerate(vec):
            out[i] += float(val)
    return [x / float(n) for x in out]


def _euclidean(a, b):
    return math.sqrt(sum((float(x) - float(y)) ** 2 for x, y in zip(a, b)))


def _kmeans(vectors, k=2, max_iter=100):
    # vectors: list of lists of floats
    n = len(vectors)
    if n == 0:
        return [], []
    m = len(vectors[0])
    # initialize centroids: choose k distinct random vectors (or repeated if less)
    k = max(1, min(k, n))
    seeds = random.sample(range(n), k) if n >= k else [0] * k
    centroids = [list(vectors[i]) for i in seeds]

    labels = [0] * n
    for _ in range(max_iter):
        changed = False
        # assign
        for idx, v in enumerate(vectors):
            best = 0
            best_d = _euclidean(v, centroids[0])
            for ci in range(1, k):
                d = _euclidean(v, centroids[ci])
                if d < best_d:
                    best_d = d
                    best = ci
            if labels[idx] != best:
                labels[idx] = best
                changed = True
        # recompute centroids
        new_centroids = [[0.0] * m for _ in range(k)]
        counts = [0] * k
        for idx, lab in enumerate(labels):
            counts[lab] += 1
            for j in range(m):
                new_centroids[lab][j] += float(vectors[idx][j])
        for ci in range(k):
            if counts[ci] == 0:
                # re-seed empty centroid with a random vector
                new_centroids[ci] = list(vectors[random.randrange(0, n)])
            else:
                new_centroids[ci] = [x / float(counts[ci]) for x in new_centroids[ci]]
        centroids = new_centroids
        if not changed:
            break
    return labels, centroids


@clustering_bp.route("/api/v1/clustering/similar-subjects", methods=["POST"])
def similar_subjects():
    """Find similar subject clusters for provided focus vectors.

    Required payload keys:
    - focusVectors: array of numeric vectors (list of lists)
    - studyProgramId: string
    Optional:
    - n_clusters: int (defaults to min(3, n_vectors) but at least 1)
    """
    payload = request.get_json(silent=True)
    if not isinstance(payload, dict):
        return jsonify({"error": "Invalid payload: expected JSON object"}), 422

    focus = payload.get("focusVectors")
    study_program = payload.get("studyProgramId")
    n_clusters = payload.get("n_clusters")

    if not isinstance(focus, (list, tuple)) or len(focus) == 0:
        return jsonify({"error": "focusVectors must be a non-empty array of numeric vectors"}), 422
    if not isinstance(study_program, str) or len(study_program) == 0:
        return jsonify({"error": "studyProgramId must be a non-empty string"}), 422

    # validate vectors and ensure consistent dimensions
    dims = None
    vectors = []
    for v in focus:
        if not _validate_numeric_vector(v):
            return jsonify({"error": "Each focus vector must be a non-empty list of numeric values"}), 422
        if dims is None:
            dims = len(v)
        elif len(v) != dims:
            return jsonify({"error": "All focus vectors must have the same dimensionality"}), 422
        vectors.append([float(x) for x in v])

    if n_clusters is None:
        k = min(3, len(vectors))
    else:
        try:
            k = int(n_clusters)
            k = max(1, min(k, len(vectors)))
        except Exception:
            return jsonify({"error": "n_clusters must be an integer"}), 422

    # compute centroid (mean of focus vectors)
    centroid = _mean_vector(vectors)

    # perform kmeans
    labels, centroids = _kmeans(vectors, k=k, max_iter=200)

    # offset logic: apply an offset to cluster indices depending on studyProgramId
    # internal rule: if study program contains 'management' (case-insensitive) -> offset 1
    # if it starts with 'INF' (case-insensitive) -> offset 0
    sp = study_program.strip().lower()
    offset_map = {"management": 1, "inf": 0}
    offset = 0
    if "management" in sp:
        offset = offset_map.get("management", 0)
    elif sp.startswith("inf") or sp == "inf":
        offset = offset_map.get("inf", 0)
    else:
        # default rule: no offset
        offset = 0

    adjusted = [int(l) + int(offset) for l in labels]

    # ensure non-empty integer array as acceptance criteria
    if not adjusted:
        return jsonify({"error": "No cluster indices produced"}), 500

    return jsonify({
        "studyProgramId": study_program,
        "offset_applied": offset,
        "cluster_indices": adjusted,
        "centroid": [float(x) for x in centroid],
    }), 200
