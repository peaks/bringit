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
import '../../data/git/git_commit.dart';

class CommitParser {
  GitCommit? map(List<String> consoleCommit) {
    if (consoleCommit.length < 3) {
      return null;
    }
    const String commitBody = 'body parsing not implemented';
    final String commitSubject = consoleCommit[1];
    const String commitEmail = 'not@yet.implemented';
    final List<String> hashTimeStampAuthor =
        _splitOnAntiSlash(consoleCommit[0]);

    return GitCommit(
        _getCommitHash(hashTimeStampAuthor),
        _buildDateFromTimeStamp(hashTimeStampAuthor),
        _getCommitAuthor(hashTimeStampAuthor),
        commitEmail,
        commitSubject,
        commitBody,
        _getReferences(consoleCommit));
  }

  String _getCommitHash(List<String> hashTimeStampAuthor) =>
      hashTimeStampAuthor.first;

  String _getCommitAuthor(List<String> hashTimeStampAuthor) =>
      hashTimeStampAuthor[2];

  List<String> _splitOnAntiSlash(String firstLine) => firstLine.split(r'\');

  DateTime _buildDateFromTimeStamp(List<String> firstLine) {
    return DateTime.fromMillisecondsSinceEpoch(
        _extractTimeStampInMilliSecond(firstLine));
  }

  int _extractTimeStampInMilliSecond(List<String> firstLine) =>
      int.parse(firstLine[1]) * 1000;

  List<String> _getReferences(List<String> commitLines) {
    if (_commitHasReferences(commitLines)) {
      return _splitOnCommaAfterRemovingHead(_getCommitAuthor(commitLines))
          .toList();
    }

    return <String>[];
  }

  Iterable<String> _splitOnCommaAfterRemovingHead(String references) {
    return references
        .replaceAll('HEAD ->', '')
        .split(',')
        .map((String ref) => ref.trim());
  }

  bool _commitHasReferences(Iterable<String> commitLines) =>
      commitLines.elementAt(2).trim().isNotEmpty;
}
