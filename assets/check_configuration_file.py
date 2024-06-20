import os

assert os.path.exists(os.getenv("CONFIG_FILE")) , f"Configuration file {os.getenv('CONFIG_FILE')} doesn't exist"