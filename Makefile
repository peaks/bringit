.PHONY: test fixtures clean
.SILENT:

clean:
	flutter analyze
	printf "=> Formatting...\n"
	flutter format .

test: test-with-filesystem
	printf "=> Finishing tests\n"
	flutter test -x file-system-dependent

test-with-filesystem: fixtures
	printf "=> Running tests depending on git commands\n"
	flutter test -t file-system-dependent

fixtures:
	printf "=> Preparing fixture files\n"
	./test/scripts/filesystem_fixtures.sh
