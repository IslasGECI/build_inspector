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

clean:

coverage: setup tests

format:

install:

linter:

mutants:

setup:

tests: install
	shellspec tests
