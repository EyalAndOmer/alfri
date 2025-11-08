"""Configuration loader for ml_service

Loads configuration from environment variables and supports a JSON MODEL_MAP.
"""
import os
import json
from typing import Dict, Any, List


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
    - API_KEYS: list of allowed API keys (parsed from API_KEYS or API_KEY env vars)
    """

    MODE = os.getenv("MODE", "dev")
    LOG_LEVEL = os.getenv("LOG_LEVEL", "INFO")
    MODEL_MAP = _parse_json_env("MODEL_MAP", default={}) or {}

    # API key handling: either a single key in API_KEY or a comma-separated list in API_KEYS.
    # If neither is set, API_KEYS will be an empty list (treated as "no keys configured").
    _raw_api_keys = os.getenv("API_KEYS") or os.getenv("API_KEY") or ""
    # split by comma and strip whitespace, filter out empty strings
    API_KEYS: List[str] = [k.strip() for k in _raw_api_keys.split(",") if k.strip()] if _raw_api_keys else []

    # Add other config defaults as needed

    def as_dict(self) -> Dict[str, Any]:
        return {k: v for k, v in self.__class__.__dict__.items() if k.isupper()}
