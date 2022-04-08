.PHONY: test fixtures
.SILENT:

test: test-with-git
	printf "=> Finishing tests\n"
	flutter test -x git-interpreter

test-with-git: fixtures
	printf "=> Running tests depending on git commands\n"
	flutter test -t git-interpreter

fixtures:
	printf "=> Preparing fixture files\n"
	./test/scripts/git_interpreter_fixtures.sh
