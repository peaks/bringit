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
import 'package:git_ihm/domain/git/log/log_parser.dart';
import 'package:git_ihm/model/git/git_commit.dart';
import 'package:test/test.dart';

late LogParser parser;

void main() {
  group('it generates commit list from git log results', () {
    setUp(() {
      parser = LogParser(CommitParser());
    });

    test('it maps git log result into GitCommit list', () async {
      final List<String> rawLog = <String>[
        r'a0ed12h\1655709244\lreus',
        'commit subject',
        'HEAD -> master'
      ];

      final List<GitCommit> parsedCommits =
          (await parser.mapIntoCommits(rawLog)).toList();

      final List<GitCommit> expectedCommits = <GitCommit>[
        GitCommit(
            'a0ed12h',
            DateTime.fromMillisecondsSinceEpoch(1655709244 * 1000),
            'lreus',
            'not@yet.implemented',
            'commit subject',
            'commit body',
            const <String>['master'])
      ];

      _listAreEquals(parsedCommits, expectedCommits);
    });

    test('it maps git log results in several GitCommit', () async {
      final List<String> rawLog = <String>[
        r'a0ed12h\1655709244\lreus',
        'next commit',
        'HEAD -> master',
        r'a0ed13f\1655400000\lreus',
        'first commit',
        'origin/another-feat'
      ];

      final List<GitCommit> parsedCommits =
          (await parser.mapIntoCommits(rawLog)).toList();

      final List<GitCommit> expectedCommits = <GitCommit>[
        GitCommit(
            'a0ed12h',
            DateTime.fromMillisecondsSinceEpoch(1655709244 * 1000),
            'lreus',
            'not@yet.implemented',
            'next commit',
            '',
            const <String>['master']),
        GitCommit(
            'a0ed13f',
            DateTime.fromMillisecondsSinceEpoch(1655400000 * 1000),
            'lreus',
            'not@yet.implemented',
            'first commit',
            '',
            const <String>['origin/another-feat'])
      ];

      _listAreEquals(parsedCommits, expectedCommits);
    });
  });
}

bool _listAreEquals(List<GitCommit> expected, List<GitCommit> testResult) {
  bool isTestEqualTooExpectation = true;
  if (expected.length != testResult.length) {
    isTestEqualTooExpectation = false;
  }

  for (final GitCommit expectedCommit in expected) {
    if (!testResult.contains(expectedCommit)) {
      isTestEqualTooExpectation = false;
    }
  }
  return isTestEqualTooExpectation;
}
