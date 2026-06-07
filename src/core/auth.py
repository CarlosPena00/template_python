from fastapi import HTTPException
from fastapi import Security
from fastapi.security import APIKeyHeader

from src.core.settings import settings

api_key_header = APIKeyHeader(name="X-API-Key")


def verify_token(token: str = Security(api_key_header)) -> str:
    if token != settings.API_KEY:
        raise HTTPException(status_code=401, detail="Invalid API key")
    return token
