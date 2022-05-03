import 'package:git_ihm/git/base_command/version_fetcher.dart';
import 'package:test/test.dart';

final RegExp gitVersionRegex =
    RegExp(r'^git version [1-9](\.[0-9]{0,2}){0,2}$');

void expectIsAGitVersionMessage(String testedMessage) {
  expect(gitVersionRegex.hasMatch(testedMessage), equals(true),
      reason: '"$testedMessage" did not match "git version X.XX.XX" message');
}

void main() {
  test('version message matches regex', () {
    final List<String> versions = <String>[
      'git version 1',
      'git version 1.0',
      'git version 1.1',
      'git version 1.30',
      'git version 2.32.0',
      'git version 1.32.4',
      'git version 3.32.42',
    ];

    versions.forEach(expectIsAGitVersionMessage);
  });

  test('it returns the git version message', () async {
    final VersionFetcher command = VersionFetcher();
    final String stdout = await command.fetch();
    expectIsAGitVersionMessage(stdout);
  });
}
