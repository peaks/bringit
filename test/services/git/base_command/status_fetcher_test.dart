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
@Tags(<String>['file-system-dependent'])

import 'dart:io';

import 'package:git_ihm/services/git/base_command/status_fetcher.dart';
import 'package:test/test.dart';

void main() {
  final StatusFetcher fetcher = StatusFetcher();
  const String path = '/tmp/git-ihm/gitProject';
  late List<String> createdFiles;

  Future<File> createEmptyFile(String fileName) async {
    final String fullPath = '$path/$fileName';
    createdFiles.add(fullPath);
    return File(fullPath).writeAsString('');
  }

  setUp(() {
    createdFiles = <String>[];
  });

  test('returns "git status" results as a list of strings', () async {
    const String untrackedFile = 'new_file.txt';
    await createEmptyFile(untrackedFile);

    final List<String> result = await fetcher.fetch(path);
    expect(result.contains('?? $untrackedFile'), equals(true));
  });

  // Future<void> createIgnoredFile(String fileName) async {
  //   await createEmptyFile(fileName);
  //   await File('$path/.gitignore').writeAsString(fileName);
  //   createdFiles.add('$path/.gitignore');
  // }

  // test('show ignored files', () async {
  //   const String ignoredFile = 'ignored.txt';
  //   await createIgnoredFile(ignoredFile);
  //
  //   final List<String> result = await fetcher.fetch(path);
  //   expect(result.contains('!! $ignoredFile'), equals(true));
  // });

  tearDown(() {
    for (final String path in createdFiles) {
      final File createdFile = File(path);
      createdFile.delete();
    }
  });
}
