@Tags(<String>['file-system-dependent'])

import 'package:git_ihm/git/base_command/log_fetcher.dart';
import 'package:test/test.dart';

void main() {
  final LogFetcher fetcher = LogFetcher();
  const String gitProjectPath = '/tmp/git-ihm/gitProject';

  Future<List<String>> _doTest() => fetcher.fetch(gitProjectPath);

  test('initial commit is returned in 3 lines', () async {
    expect((await _doTest()).length, 3);
  });

  test('First line has Hash, Timestamp and author between antislashes',
      () async {
    expect(_hashDateAndAuthorRegExp().hasMatch((await _doTest())[0]), true);
  });

  test('Second line gets commit title', () async {
    expect((await _doTest())[1], 'initial commit');
  });

  test('Third line gets commit reference', () async {
    expect((await _doTest())[2], 'HEAD -> master');
  });
}

RegExp _hashDateAndAuthorRegExp() {
  const String abbreviatedHash = '[a-z0-9]{7}';
  const String Timestamp = '[0-9]{10}';
  const String author = '.*';
  const String separator = r'\\';

  return RegExp(
      '^' + abbreviatedHash + separator + Timestamp + separator + author);
}
