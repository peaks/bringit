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
import 'package:git_ihm/git/parsers/status_parser.dart';

import '../data/git/git_status_command.dart';
import '../data/git/status_file.dart';
import 'base_command/status_fetcher.dart';

class GitStatusImplementation extends GitStatusCommand {
  GitStatusImplementation(this._parser, this._baseCommand);

  final StatusParser _parser;
  final StatusFetcher _baseCommand;

  @override
  Future<List<StatusFile>> run(String path) async {
    _parser.setProject(path);
    return _map(await _baseCommand.fetch(path));
  }

  List<StatusFile> _map(List<String> gitStatus) {
    final List<StatusFile> results = <StatusFile>[];

    for (final String element in gitStatus) {
      results.add(_parser.parse(element));
    }

    return results;
  }
}
