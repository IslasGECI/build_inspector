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
	shellcheck --shell=bash src/helper.sh

clean:
	rm --force --recursive repositorio

coverage: setup tests

format:

install:

linter:

mutants:

setup:

tests:
	shellspec --shell bash tests
