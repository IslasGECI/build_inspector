all: check coverage mutants

.PHONY: \
		all \
		check \
		clean \
		coverage \
		format \
		install \
		linter \
		mutants \
		tests

module = build_inspector
codecov_token = e0368ff3-afab-475b-986b-1bd77c03cf23

define lint
	pylint \
        --disable=bad-continuation \
        --disable=missing-class-docstring \
        --disable=missing-function-docstring \
        --disable=missing-module-docstring \
        ${1}
endef

check:
	black --check --line-length 100 ${module}
	black --check --line-length 100 tests
	flake8 --max-line-length 100 ${module}
	flake8 --max-line-length 100 tests
	mypy ${module}
	mypy tests

clean:
	rm --force --recursive .*_cache
	rm --force --recursive ${module}.egg-info
	rm --force --recursive ${module}/__pycache__
	rm --force --recursive tests/__pycache__
	rm --force .mutmut-cache
	rm --force coverage.xml

coverage: install
	pytest --cov=${module} --cov-report=xml --verbose && \
	codecov --token=${codecov_token}

format:
	black --line-length 100 ${module}
	black --line-length 100 tests

install:
	pip install .

linter:
	$(call lint, ${module})
	$(call lint, tests)

mutants:
	mutmut run --paths-to-mutate ${module}

tests: install
	pytest --verbose
