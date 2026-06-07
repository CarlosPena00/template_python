from pydantic_settings import BaseSettings
from pydantic_settings import SettingsConfigDict


class Settings(BaseSettings):
    API_KEY: str = "banana"

    model_config = SettingsConfigDict(env_file=".env", env_file_encoding="utf-8")


settings = Settings(**{})
