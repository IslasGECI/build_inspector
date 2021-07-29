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
	rm --force --recursive isla-guadalupe
	rm --force --recursive repositorio
	rm --force --recursive repository

coverage: setup tests

format:

install:

linter:

mutants:

setup:

tests:
	shellspec --shell bash tests
