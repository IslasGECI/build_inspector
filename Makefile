all: coverage

.PHONY: \
		all \
		check \
		clean \
		coverage \
		format \
		install \
		linter \
		mutants \
		setup \
		tests

check:
	shellcheck --shell=bash src/*

clean:
	rm --force --recursive coverage
	rm --force --recursive isla-guadalupe
	rm --force --recursive repositorio
	rm --force --recursive repository

coverage: setup
	shellspec --kcov --kcov-options "--include-path=src" --shell bash tests

format:

install:

linter:

mutants:

setup:

tests:
	shellspec --shell bash tests
