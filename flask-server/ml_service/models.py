"""Model loading placeholder

This module provides a simple load_models function that simulates
loading and then sets `app.config['MODELS_LOADED'] = True`.
"""
import time
import logging

logger = logging.getLogger(__name__)


def load_models(config):
    """Placeholder model loading routine.

    - Reads MODEL_MAP from config
    - Simulates loading each model (sleep)
    - Sets MODELS_LOADED flag in provided config object (if it's a Flask config)
    """
    model_map = config.get("MODEL_MAP", {}) if hasattr(config, "get") else getattr(config, "MODEL_MAP", {})
    logger.info("Starting model load for %d models", len(model_map))

    # Simulate per-model loading time (short for dev)
    for name, meta in (model_map.items() if isinstance(model_map, dict) else []):
        logger.info("Loading model %s -> %s", name, meta)
        time.sleep(0.1)

    # If config is a Flask config mapping, set readiness flag
    try:
        if hasattr(config, "__setitem__"):
            config["MODELS_LOADED"] = True
        else:
            # fallback: try to set attribute
            setattr(config, "MODELS_LOADED", True)
    except Exception:
        logger.exception("Failed to set MODELS_LOADED flag on config")

    logger.info("Models flagged as loaded")

