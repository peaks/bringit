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

import 'package:git_ihm/git/base_command/terminal_command.dart';

class StatusFetcher {
  static const LineSplitter _splitter = LineSplitter();

  Future<List<String>> fetch(String path) async {
    final String results = await _callGitStatus(path);
    return _splitter.convert(results);
  }

  Future<String> _callGitStatus(String path) async {
    // don't send back ignored files
    final TerminalCommand command = TerminalCommand(
        'git', <String>['status', '--porcelain=v1', '--ignored=no']);

    return command.run(path);
  }
}
