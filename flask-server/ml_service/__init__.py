"""ml_service package - app factory and wiring
"""
from flask import Flask

from .logging_setup import configure_logging


def create_app(test_config=None):
    """Application factory - returns configured Flask app.

    - Configures logging
    - Loads configuration from Config object
    - Registers blueprints
    - Kicks off model loading in a background thread (placeholder)
    """
    configure_logging()

    app = Flask(__name__, instance_relative_config=False)

    # load config from the Config object
    from .config import Config
    app.config.from_object(Config())

    # register blueprints
    from .blueprints.health import health_bp
    app.register_blueprint(health_bp)

    # start model loading in background (non-blocking)
    from . import models
    import threading

    def _load_models():
        try:
            models.load_models(app.config)
            app.logger.info("Model loading completed.")
        except Exception:
            app.logger.exception("Model loading failed")

    loader_thread = threading.Thread(target=_load_models, daemon=True)
    loader_thread.start()

    return app

