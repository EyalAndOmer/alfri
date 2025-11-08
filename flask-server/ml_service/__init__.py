"""ml_service package - app factory and wiring
"""
from flask import Flask, jsonify

from .logging_setup import configure_logging


def create_app(test_config=None):
    """Application factory - returns configured Flask app.

    - Configures logging
    - Loads configuration from Config object
    - Registers blueprints
    - Kicks off model loading in a background thread (placeholder)
    - Registers JSON error handlers for APIError subclasses
    """
    configure_logging()

    app = Flask(__name__, instance_relative_config=False)

    # load config from the Config object
    from .config import Config
    app.config.from_object(Config())

    # register blueprints
    from .blueprints.health import health_bp
    app.register_blueprint(health_bp)

    # register predict blueprint
    from .blueprints.predict import predict_bp
    app.register_blueprint(predict_bp)

    # register JSON error handlers for our API errors
    from . import errors

    @app.errorhandler(errors.APIError)
    def _handle_api_error(err):
        payload = {"error": err.to_dict()}
        return jsonify(payload), getattr(err, "status_code", 500)

    @app.errorhandler(Exception)
    def _handle_unexpected_error(err):
        # Log and return a generic internal error payload without exposing internals
        app.logger.exception("Unhandled exception: %s", err)
        internal = errors.InternalError("Internal server error")
        return jsonify({"error": internal.to_dict()}), internal.status_code

    # start model loading in background (non-blocking)
    from . import models
    import threading

    def _load_models():
        try:
            # load models and keep registry on config for handlers to use
            registry = models.load_models(app.config)
            app.config["MODEL_REGISTRY"] = registry
            app.logger.info("Model loading completed.")
        except Exception:
            app.logger.exception("Model loading failed")

    loader_thread = threading.Thread(target=_load_models, daemon=True)
    loader_thread.start()

    return app
