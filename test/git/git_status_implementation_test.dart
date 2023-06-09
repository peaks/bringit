/*
 * Copyright (c) 2020 Peaks
 *
 * This file is part of GitGud
 *
 * GitGud is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * GitGud is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with GitGud.  If not, see <http://www.gnu.org/licenses/>.
 */
import 'package:git_ihm/data/git/git_status_command.dart';
import 'package:git_ihm/data/git/status_file.dart';
import 'package:git_ihm/git/git_status_implementation.dart';
import 'package:git_ihm/git/parsers/status_parser.dart';
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

    final List<StatusFile> result = await command.run(projectPath);

    expect(
        result.contains(const UntrackedPath('$projectPath$filePath')), isTrue);
  });

  test('returns modified file in results', () async {
    const String filePath = 'my/modified/file/path';
    mockedCommand.pushModifiedResult(filePath);

    final List<StatusFile> result = await command.run(projectPath);

    expect(
        result.contains(const ModifiedFile('$projectPath$filePath')), isTrue);
  });

  test('returns added files in results', () async {
    const String filePath1 = 'my/added/file1/path';
    const String filePath2 = 'my/added/file2/path';
    mockedCommand.pushModifiedOrAddedResult(filePath1);
    mockedCommand.pushUntrackedAndAdded(filePath2);

    final List<StatusFile> result = await command.run(projectPath);

    expect(result.contains(const AddedFile('$projectPath$filePath1')), isTrue);
    expect(result.contains(const AddedFile('$projectPath$filePath2')), isTrue);
  });

  test('returns ignored file in results', () async {
    const String filePath = 'my/modified/file/path';
    mockedCommand.pushIgnoredResult(filePath);

    final List<StatusFile> result = await command.run(projectPath);

    expect(result.contains(const IgnoredFile('$projectPath$filePath')), isTrue);
  });
}
