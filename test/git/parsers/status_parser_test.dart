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
import 'package:git_ihm/data/git/status_file.dart';
import 'package:git_ihm/git/parsers/status_parser.dart';
import 'package:test/test.dart';

void main() {
  final StatusParser interpreter = StatusParser();
  const String gitFilePath = 'foo/bar';

  StatusFile doParseTest(String statusLine) => interpreter.parse(statusLine);

  test('throws an unimplementedException on missing prefix', () {
    expect(() => doParseTest(gitFilePath), throwsException);
  });

  void expectWillMatch(
      String originalPattern, GitFileState expectedState, String expectedPath) {
    final StatusFile actual = doParseTest(originalPattern);
    expect(actual.state, equals(expectedState));
    expect(actual.path, equals(expectedPath));
  }

  test('prefix "??" returns an untracked file', () {
    expectWillMatch('?? $gitFilePath', GitFileState.untracked, gitFilePath);
  });

  test('prefix " M" returns a modified file', () {
    expectWillMatch(' M $gitFilePath', GitFileState.modified, gitFilePath);
  });

  test('prefixes "A " and "M " return an added file', () {
    for (final String prefix in <String>['A ', 'M ']) {
      expectWillMatch('$prefix $gitFilePath', GitFileState.added, gitFilePath);
    }
  });

  test('prefix !! returns an ignored file', () {
    expectWillMatch('!! $gitFilePath', GitFileState.ignored, gitFilePath);
  });

  test('mapping a renamed file', () {
    const String oldPath = 'lib/git/parsers/status_parser.dart';
    const String newPath = 'lib/git/parsers/new_name.dart';

    expectWillMatch('R  $oldPath -> $newPath', GitFileState.renamed, newPath);
  });

  test('provided prefix is appended to file path', () {
    const String pathEndingWithSeparator = '/root/project/directory/';
    interpreter.setProject(pathEndingWithSeparator);

    final StatusFile result = interpreter.parse('?? $gitFilePath');
    expect(result.path, equals('$pathEndingWithSeparator$gitFilePath'));
  });

  test('separator is appended to prefix if missing', () {
    const String pathMissingEndingSeparator = '/root/project/directory';
    interpreter.setProject(pathMissingEndingSeparator);

    final StatusFile result = interpreter.parse('?? test.txt');
    expect(result.path, equals('$pathMissingEndingSeparator/test.txt'));
  });
}
