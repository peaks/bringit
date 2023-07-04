/*
 * Copyright (c) 2020 Peaks
 *
 * This file is part of Brin'Git
 *
 * Brin'Git is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * Brin'Git is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with Brin'Git.  If not, see <http://www.gnu.org/licenses/>.
 */
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
