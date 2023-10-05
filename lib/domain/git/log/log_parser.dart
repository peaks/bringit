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
import 'package:git_ihm/domain/git/commit/commit_parser.dart';
import 'package:git_ihm/model/git/git_commit.dart';

class LogParser {
  LogParser(this._parser);

  final CommitParser _parser;

  Future<List<GitCommit>> mapIntoCommits(List<String> logLines) async {
    final List<GitCommit> result = <GitCommit>[];

    await for (final List<String> chunk in _parseByGroupOfThree(logLines)) {
      _addToResult(_parser.map(chunk), result);
    }

    return result;
  }

  Stream<List<String>> _parseByGroupOfThree(List<String> logContent) async* {
    final Iterator<String> iterator = logContent.iterator;
    final List<String> chunk = <String>[];

    while (iterator.moveNext()) {
      chunk.add(iterator.current);
      if (chunk.length == 3) {
        yield chunk;
        chunk.clear();
      }
    }
  }

  void _addToResult(GitCommit? commit, List<GitCommit> result) {
    if (commit is GitCommit) {
      result.add(commit);
    }
  }
}
