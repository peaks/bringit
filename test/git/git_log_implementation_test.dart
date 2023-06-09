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
import 'package:git_ihm/data/git/git_commit.dart';
import 'package:git_ihm/git/base_command/log_fetcher.dart';
import 'package:git_ihm/git/git_log_implementation.dart';
import 'package:git_ihm/git/parsers/commit_parser.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

late LogFetcher fetcher;
late CommitParser parser;

void main() {
  group('it generates commit list from git log results', () {
    setUp(() {
      parser = CommitParser();
    });

    Future<List<GitCommit>> _doTest(String workingDirectory) async {
      final GitLogImplementation i = GitLogImplementation(fetcher, parser);
      return await i.run(workingDirectory);
    }

    Future<void> _thenImplementationReturns(List<GitCommit> expected) async {
      final List<GitCommit> testResult = await _doTest('any path');
      expect(_listAreEquals(expected, testResult), true);
    }

    test('it generates an empty list if fetcher fails', () async {
      _whenGitLogFails();
      _thenImplementationReturns(<GitCommit>[]);
    });

    void _whenFetcherReturnsLines(List<String> fetchedLines) {
      final SuccessfulFetcher mockedFetcher = SuccessfulFetcher();
      fetchedLines.forEach(mockedFetcher.fetchResult.add);
      fetcher = mockedFetcher;
    }

    test('it maps git log result into GitCommit list', () async {
      _whenFetcherReturnsLines(<String>[
        r'a0ed12h\1655709244\lreus',
        'commit subject',
        'HEAD -> master'
      ]);

      _thenImplementationReturns(<GitCommit>[
        GitCommit(
            'a0ed12h',
            DateTime.fromMillisecondsSinceEpoch(1655709244 * 1000),
            'lreus',
            'not@yet.implemented',
            'commit subject',
            'commit body',
            const <String>['master'])
      ]);
    });

    test('it maps git log results in several GitCommit', () async {
      _whenFetcherReturnsLines(<String>[
        r'a0ed12h\1655709244\lreus',
        'next commit',
        'HEAD -> master',
        r'a0ed13f\1655400000\lreus',
        'first commit',
        'origin/another-feat'
      ]);

      _thenImplementationReturns(<GitCommit>[
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
      ]);
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

void _whenGitLogFails() {
  fetcher = FailingFetcher();
}

class FailingFetcher extends Fake implements LogFetcher {
  @override
  Future<List<String>> fetch(String workingDirectory) async {
    return <String>[];
  }
}

class SuccessfulFetcher extends Fake implements LogFetcher {
  final List<String> fetchResult = <String>[];

  @override
  Future<List<String>> fetch(String workingDirectory) async {
    return fetchResult;
  }
}
