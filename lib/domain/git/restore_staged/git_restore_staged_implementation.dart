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
import 'dart:io';

import 'package:git_ihm/domain/git/base_command/command_result.dart';
import 'package:git_ihm/domain/git/base_command/shell_command.dart';
import 'package:git_ihm/domain/git/restore_staged/git_restore_staged_command.dart';

class GitRestoreStagedImplementation extends GitRestoreStagedCommand {
  GitRestoreStagedImplementation();

  @override
  Future<CommandResult<String>> run(
      String fileRelativePath, String workingDirectoryPath) async {
    final ShellCommand command =
        ShellCommand('git', <String>['restore', '--staged', fileRelativePath]);
    final ProcessResult result = await command.run(workingDirectoryPath);
    return CommandResult<String>(result.stdout.toString(), result);
  }
}
