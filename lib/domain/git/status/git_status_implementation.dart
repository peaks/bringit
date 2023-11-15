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
import 'dart:io';

import 'package:git_ihm/domain/git/base_command/command_result.dart';
import 'package:git_ihm/domain/git/base_command/shell_command.dart';
import 'package:git_ihm/domain/git/status/git_status_command.dart';
import 'package:git_ihm/domain/git/status/status_parser.dart';
import 'package:git_ihm/model/git/git_file_status.dart';

class GitStatusImplementation extends GitStatusCommand {
  GitStatusImplementation(this._parser);

  final StatusParser _parser;
  static const LineSplitter _splitter = LineSplitter();

  @override
  Future<CommandResult<List<GitFileStatus>>> run(String path) async {
    _parser.setProject(path);

    final ShellCommand command = ShellCommand(
        'git', <String>['status', '--porcelain=v1', '--ignored=no']);
    final ProcessResult result = await command.run(path);
    List<GitFileStatus> filesStatus = <GitFileStatus>[];
    if (result.isSuccessful) {
      filesStatus = _parseStatus(_splitter.convert(result.stdout.toString()));
    }
    return CommandResult<List<GitFileStatus>>(filesStatus, result);
  }

  List<GitFileStatus> _parseStatus(List<String> gitStatus) {
    final List<GitFileStatus> results = <GitFileStatus>[];

    for (final String element in gitStatus) {
      results.addAll(_parser.parse(element));
    }

    return results;
  }
}
