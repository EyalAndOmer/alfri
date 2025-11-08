"""Simple CLI helper to run the dev server"""
from . import create_app


def main():
    app = create_app()
    app.run(host="0.0.0.0", port=5000, debug=(app.config.get("MODE") == "dev"))


if __name__ == "__main__":
    main()

