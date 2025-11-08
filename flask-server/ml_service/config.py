"""Configuration loader for ml_service

Loads configuration from environment variables and supports a JSON MODEL_MAP.
"""
import os
import json
from typing import Dict, Any


def _parse_json_env(var_name: str, default=None):
    val = os.getenv(var_name)
    if not val:
        return default
    try:
        return json.loads(val)
    except json.JSONDecodeError:
        raise ValueError(f"Environment variable {var_name} contains invalid JSON")


class Config:
    """Minimal config object used by Flask.

    Exposes:
    - MODEL_MAP: dict mapping model names to metadata (from JSON env var MODEL_MAP)
    - LOG_LEVEL: logging level
    - MODE: 'dev' or 'prod'
    """

    MODE = os.getenv("MODE", "dev")
    LOG_LEVEL = os.getenv("LOG_LEVEL", "INFO")
    MODEL_MAP = _parse_json_env("MODEL_MAP", default={}) or {}

    # Add other config defaults as needed

    def as_dict(self) -> Dict[str, Any]:
        return {k: v for k, v in self.__class__.__dict__.items() if k.isupper()}

