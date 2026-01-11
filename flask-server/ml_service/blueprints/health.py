"""Health endpoints blueprint

Provides:
- GET /health/live -> 200 always
- GET /health/ready -> 200 when models loaded, 503 otherwise
"""
from flask import Blueprint, current_app, jsonify

health_bp = Blueprint("health", __name__)


@health_bp.route("/health/live", methods=["GET"])
def live():
    return jsonify({"status": "alive"}), 200


@health_bp.route("/health/ready", methods=["GET"])
def ready():
    # models.py will set an app.config flag when models are loaded
    ready_flag = current_app.config.get("MODELS_LOADED", False)
    if ready_flag:
        return jsonify({"status": "ready"}), 200
    return jsonify({"status": "not ready"}), 503

