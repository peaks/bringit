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
import 'package:git_ihm/domain/git/status/status_parser.dart';
import 'package:git_ihm/model/git/git_file_status.dart';
import 'package:test/test.dart';

void main() {
  final StatusParser interpreter = StatusParser();
  const String gitFilePath = 'foo/bar';

  List<GitFileStatus> doParseTest(String statusLine) =>
      interpreter.parse(statusLine);

  test('throws an unimplementedException on missing prefix', () {
    expect(() => doParseTest(gitFilePath), throwsException);
  });

  void expectWillMatch(
      String originalPattern, GitFileState expectedState, String expectedPath) {
    final List<GitFileStatus> actual = doParseTest(originalPattern);
    expect(actual.first.state, equals(expectedState));
    expect(actual.first.fileAbsolutePath, equals(expectedPath));
  }

  test('prefix "??" returns an untracked file', () {
    expectWillMatch('?? $gitFilePath', GitFileState.untracked, gitFilePath);
  });

  test('prefix " M", "M " and "MM" returns a modified file', () {
    expectWillMatch(' M $gitFilePath', GitFileState.modified, gitFilePath);
  });

  test('prefixes "A " and "AM" return an added file', () {
    for (final String prefix in <String>['A ', 'AM']) {
      expectWillMatch('$prefix $gitFilePath', GitFileState.added, gitFilePath);
    }
  });

  test('mapping a renamed file', () {
    const String oldPath = 'lib/git/parsers/status_parser.dart';
    const String newPath = 'lib/git/parsers/new_name.dart';

    expectWillMatch('R  $oldPath -> $newPath', GitFileState.renamed,
        '$oldPath -> $newPath');
  });

  test('provided prefix is appended to file path', () {
    const String pathEndingWithSeparator = '/root/project/directory/';
    interpreter.setProject(pathEndingWithSeparator);

    final List<GitFileStatus> result = interpreter.parse('?? $gitFilePath');
    expect(result.first.fileAbsolutePath,
        equals('$pathEndingWithSeparator$gitFilePath'));
  });

  test('separator is appended to prefix if missing', () {
    const String pathMissingEndingSeparator = '/root/project/directory';
    interpreter.setProject(pathMissingEndingSeparator);

    final List<GitFileStatus> result = interpreter.parse('?? test.txt');
    expect(result.first.fileAbsolutePath,
        equals('$pathMissingEndingSeparator/test.txt'));
  });
}
