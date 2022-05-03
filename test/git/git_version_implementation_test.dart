import 'package:git_ihm/git/base_command/version_fetcher.dart';
import 'package:git_ihm/git/git_version_implementation.dart';
import 'package:test/test.dart';

void main() {
  test('it returns an empty string if mock fetch is empty', () async {
    final VersionFetcherMock mock = VersionFetcherMock();
    final GitVersionImplementation command = GitVersionImplementation(mock);
    mock.willReturn('');
    expect(await command.run(), equals(''));
  });

  test('it returns an empty string if no version number can be found',
      () async {
    final VersionFetcherMock mock = VersionFetcherMock();
    final GitVersionImplementation command = GitVersionImplementation(mock);
    mock.willReturn('not a git directory');
    expect(await command.run(), equals(''));
  });

  test('it returns version number from mock result', () async {
    final VersionFetcherMock mock = VersionFetcherMock();
    final GitVersionImplementation command = GitVersionImplementation(mock);
    mock.willReturn('git version 2.25.2');
    expect(await command.run(), equals('2.25.2'));
  });
}

class VersionFetcherMock extends VersionFetcher {
  String _expectedResult = '';

  void willReturn(String s) {
    _expectedResult = s;
  }

  @override
  Future<String> fetch() async {
    return _expectedResult;
  }
}
