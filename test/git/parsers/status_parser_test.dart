import 'package:git_ihm/data/git/status_file.dart';
import 'package:git_ihm/git/parsers/status_parser.dart';
import 'package:test/test.dart';

void main() {
  final StatusParser interpreter = StatusParser();
  const String filePath = '/foo/bar';

  StatusFile doParseTest(String statusLine) => interpreter.parse(statusLine);

  test('throws an unimplementedException on missing prefix', () {
    expect(() => doParseTest(filePath), throwsException);
  });

  void expectWillMatch(
      String originalPattern, GitFileState expectedState, String expectedPath) {
    final StatusFile actual = doParseTest(originalPattern);
    expect(actual.state, equals(expectedState));
    expect(actual.path, equals(expectedPath));
  }

  test('prefix "??" returns an untracked file', () {
    expectWillMatch('?? $filePath', GitFileState.untracked, filePath);
  });

  test('prefix " M" returns a modified file', () {
    expectWillMatch(' M $filePath', GitFileState.modified, filePath);
  });

  test('prefixes returning an added file', () {
    for (final String prefix in <String>['A ', 'M ']) {
      expectWillMatch('$prefix $filePath', GitFileState.added, filePath);
    }
  });

  test('mapping a renamed file', () {
    const String oldPath = 'lib/git/parsers/status_parser.dart';
    const String newPath = 'lib/git/parsers/new_name.dart';

    expectWillMatch('R  $oldPath -> $newPath', GitFileState.renamed, newPath);
  });
}
