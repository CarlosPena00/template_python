from fastapi import Depends
from fastapi import FastAPI
from fastapi.responses import RedirectResponse

from src.core.auth import verify_token

app = FastAPI(swagger_ui_parameters={"displayRequestDuration": True})


@app.get("/")
def to_docs() -> RedirectResponse:
    return RedirectResponse("/docs")


@app.get("/ping")
def ping_api() -> str:
    return "pong"


@app.get("/protected", dependencies=[Depends(verify_token)])
def protected_route() -> str:
    return "secret-value"
