import 'package:git_ihm/data/git/status_file.dart';
import 'package:git_ihm/git/parsers/status_parser.dart';
import 'package:test/test.dart';

void main() {
  final StatusParser interpreter= StatusParser();
  const String filePath = '/foo/bar';

  StatusFile doParseTest(String statusLine) => interpreter.parse(statusLine);

  void expectFileMatch(
      StatusFile actual, GitFileState expectedState, String expectedPath) {
    expect(actual.state, equals(expectedState));
    expect(actual.path, equals(expectedPath));
  }

  test('throws an unimplementedException on missing prefix', () {
    expect(() => doParseTest(filePath), throwsException);
  });

  test('prefix "??" returns an untracked file', () {
    expectFileMatch(
        doParseTest('?? $filePath'), GitFileState.untracked, filePath);
  });

  test('prefix " M" returns a modified file', () {
    expectFileMatch(
        doParseTest(' M $filePath'), GitFileState.modified, filePath);
  });

  test('prefixes returning an added file', () {
    for (final String prefix in <String>['A ', 'M ']) {
      expectFileMatch(
          doParseTest('$prefix $filePath'), GitFileState.added, filePath);
    }
  });
}