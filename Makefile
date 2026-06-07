all: deps check test

# APT_DEPS := gcc libpq-dev
deps: .venv
	@# @dpkg-query -s $(APT_DEPS) >/dev/null 2>&1 || (echo 'missing deps! please run: sudo apt install $(APT_DEPS)'; exit 1)

.venv:
	uv sync --locked
	uv run pre-commit install

check:
	uv run pre-commit run --all-files

test:
	uv run coverage erase
	uv run coverage run --source . --branch -m pytest

cov:
	test -f .coverage || $(MAKE) -s test
	uv run coverage report --show-missing --skip-covered --include 'tests/*' --fail-under 100
	uv run coverage report --show-missing --skip-covered --omit 'tests/*'

clean:
	rm -rf .venv/ .*_cache/ .coverage *.egg-info/ dist/
	find -type d -name '__pycache__' -exec rm -rf {} +
