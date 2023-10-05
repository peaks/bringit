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

import '../../mock/git_status_generator.dart';

void main() {
  late StatusParser statusParser;
  late GitStatusGenerator statusGenerator;
  const String projectPath = '/any/path/';

  setUp(() {
    statusParser = StatusParser();
    statusParser.setProject(projectPath);
    statusGenerator = GitStatusGenerator();
  });

  test('create class', () {
    expect(statusParser, isA<StatusParser>());
  });

  test('returns empty list when status command returns empty list', () async {
    expect(statusParser.parse(''), isEmpty);
  });

  test('returns untracked file in results', () async {
    const String filePath = 'my/untracked/file/path';
    statusGenerator.pushUntrackedResult(filePath);

    final String stdout = statusGenerator.stdout;
    final List<GitFileStatus> result = statusParser.parse(stdout);

    expect(
        result.contains(const UntrackedPath('$projectPath$filePath', filePath)),
        isTrue);
  });

  test('returns deleted file in results', () async {
    const String filePath = 'my/deleted/file/path';
    statusGenerator.pushDeletedStagedResult(filePath);

    final String stdout = statusGenerator.stdout;
    final List<GitFileStatus> result = statusParser.parse(stdout);
    expect(
        result.contains(const DeletedFile('$projectPath$filePath', filePath)),
        isTrue);
  });

  test('returns renamed file in results', () async {
    const String filePath = 'my/oldName/file/path';
    const String filePath1 = 'my/renamed/file1/path';
    const String filePath2 = 'my/renamed/file2/path';
    statusGenerator.pushRenamedResult(filePath1, filePath);
    statusGenerator.pushRenamedUnstagedResult(filePath2, filePath);

    final String stdout = statusGenerator.stdout;
    final List<GitFileStatus> result = <GitFileStatus>[];
    for (final String line in stdout.split('\n')) {
      result.addAll(statusParser.parse(line));
    }
    expect(
        result.contains(const RenamedFile(
            '$projectPath$filePath -> $filePath1', '$filePath -> $filePath1')),
        isTrue);
    expect(
        result.contains(const RenamedFile('$projectPath$filePath2', filePath2)),
        isTrue);
  });

  test('returns modified file in results', () async {
    const String filePath1 = 'my/modified/file1/path';
    const String filePath2 = 'my/modified/file2/path';
    const String filePath3 = 'my/modified/file3/path';
    statusGenerator.pushModifiedUnstagedResult(filePath1);
    statusGenerator.pushModifiedStagedResult(filePath2);
    statusGenerator.pushModifiedStagedThenModifiedResult(filePath3);

    final String stdout = statusGenerator.stdout;
    final List<GitFileStatus> result = <GitFileStatus>[];
    for (final String line in stdout.split('\n')) {
      result.addAll(statusParser.parse(line));
    }

    expect(
        result
            .contains(const ModifiedFile('$projectPath$filePath1', filePath1)),
        isTrue);
    expect(
        result
            .contains(const ModifiedFile('$projectPath$filePath2', filePath2)),
        isTrue);
    expect(
        result
            .contains(const ModifiedFile('$projectPath$filePath3', filePath3)),
        isTrue);
  });

  test('returns added files in results', () async {
    const String filePath1 = 'my/added/file1/path';
    const String filePath2 = 'my/added/file2/path';
    statusGenerator.pushAdded(filePath1);
    statusGenerator.pushAddedModified(filePath2);

    final String stdout = statusGenerator.stdout;
    final List<GitFileStatus> result = <GitFileStatus>[];
    for (final String line in stdout.split('\n')) {
      result.addAll(statusParser.parse(line));
    }

    expect(
        result.contains(const AddedFile('$projectPath$filePath1', filePath1)),
        isTrue);
    expect(
        result.contains(const AddedFile('$projectPath$filePath2', filePath2)),
        isTrue);
  });
}
