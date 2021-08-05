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
		setup \
		tests

check:
	shellcheck --shell=bash src/*.sh

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
	@echo "🏹😞 No mutation testing on Bash 👾🎉👾"

setup:

tests:
	shellspec --shell bash tests
