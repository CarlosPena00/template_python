# file: Dockerfile
FROM python:3.14-slim AS base

COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

ENV \
    PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PYTHONFAULTHANDLER=1 \
    PYTHONHASHSEED=random \
    UV_COMPILE_BYTECODE=1 \
    UV_LINK_MODE=copy \
    UV_PROJECT_ENVIRONMENT=/venv

ENV PATH=/venv/bin:$PATH

WORKDIR /src

# prod dependencies (no project source yet — maximizes layer cache)
COPY pyproject.toml uv.lock ./
RUN uv sync --locked --no-dev --no-install-project

# --- dev stage ------------------------------------------------------------------------
FROM base AS dev

# add dev dependencies
RUN uv sync --locked --no-install-project
COPY src /src/src
RUN uv sync --locked

# --- runtime stage --------------------------------------------------------------------
FROM base AS runtime

COPY src /src/src
RUN uv sync --locked --no-dev
COPY scripts /src/scripts
CMD ["sh", "scripts/00_start_uvicorn.sh"]
