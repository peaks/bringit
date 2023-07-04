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
