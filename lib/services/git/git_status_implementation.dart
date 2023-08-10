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
import 'package:git_ihm/services/git/git_status_command.dart';
import 'package:git_ihm/services/git/parsers/status_parser.dart';

import '../../model/git/git_file_status.dart';
import 'base_command/status_fetcher.dart';

class GitStatusImplementation extends GitStatusCommand {
  GitStatusImplementation(this._parser, this._baseCommand);

  final StatusParser _parser;
  final StatusFetcher _baseCommand;

  @override
  Future<List<GitFileStatus>> run(String path) async {
    _parser.setProject(path);
    return _parseStatus(await _baseCommand.fetch(path));
  }

  List<GitFileStatus> _parseStatus(List<String> gitStatus) {
    final List<GitFileStatus> results = <GitFileStatus>[];

    for (final String element in gitStatus) {
      results.addAll(_parser.parse(element));
    }

    return results;
  }
}
