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
import 'package:git_ihm/model/git/git_file_status.dart';
import 'package:git_ihm/services/git/git_status_command.dart';
import 'package:git_ihm/services/git/git_status_implementation.dart';
import 'package:git_ihm/services/git/parsers/status_parser.dart';
import 'package:test/test.dart';

import '../mock/status_fetcher_mock.dart';

void main() {
  late GitStatusImplementation command;
  late StatusFetcherMock mockedCommand;
  const String projectPath = '/any/path/';

  setUp(() {
    mockedCommand = StatusFetcherMock();
    mockedCommand.willRunFor(projectPath);
    command = GitStatusImplementation(StatusParser(), mockedCommand);
  });

  test('create class', () {
    expect(command, isA<GitStatusCommand>());
  });

  test('returns empty list when status command returns empty list', () async {
    expect(await command.run(projectPath), isEmpty);
  });

  test('returns untracked file in results', () async {
    const String filePath = 'my/untracked/file/path';
    mockedCommand.pushUntrackedResult(filePath);

    final List<GitFileStatus> result = await command.run(projectPath);

    expect(
        result.contains(const UntrackedPath('$projectPath$filePath', filePath)),
        isTrue);
  });

  test('returns deleted file in results', () async {
    const String filePath = 'my/deleted/file/path';
    mockedCommand.pushDeletedStagedResult(filePath);

    final List<GitFileStatus> result = await command.run(projectPath);
    expect(
        result.contains(const DeletedFile('$projectPath$filePath', filePath)),
        isTrue);
  });

  test('returns renamed file in results', () async {
    const String filePath = 'my/oldName/file/path';
    const String filePath1 = 'my/renamed/file1/path';
    const String filePath2 = 'my/renamed/file2/path';
    mockedCommand.pushRenamedResult(filePath1, filePath);
    mockedCommand.pushRenamedUnstagedResult(filePath2, filePath);

    final List<GitFileStatus> result = await command.run(projectPath);
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
    mockedCommand.pushModifiedUnstagedResult(filePath1);
    mockedCommand.pushModifiedStagedResult(filePath2);
    mockedCommand.pushModifiedStagedThenModifiedResult(filePath3);

    final List<GitFileStatus> result = await command.run(projectPath);

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
    mockedCommand.pushAdded(filePath1);
    mockedCommand.pushAddedModified(filePath2);

    final List<GitFileStatus> result = await command.run(projectPath);

    expect(
        result.contains(const AddedFile('$projectPath$filePath1', filePath1)),
        isTrue);
    expect(
        result.contains(const AddedFile('$projectPath$filePath2', filePath2)),
        isTrue);
  });
}
