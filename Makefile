.DEFAULT_GOAL := run

run:
	bash scripts/00_start_uvicorn.sh

sync:
	uv sync

test:
	uv run pytest

cov:
	uv run pytest --cov --cov-report=term-missing
