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
import 'dart:convert';

import 'package:git_ihm/domain/git/base_command/shell_command.dart';

class LogFetcher {
  Future<List<String>> fetch(String workingDirectory) async {
    return LineSplitter.split(await _callGitLog(workingDirectory)).toList();
  }

  Future<String> _callGitLog(String workingDirectory) async {
    final ShellCommand command =
        ShellCommand('git', <String>['log', r'--format=%h\%ct\%cn%n%s%n%D']);

    return await command.run(workingDirectory);
  }
}
