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
import 'package:git_ihm/domain/git/git_proxy.dart';
import 'package:git_ihm/domain/git/git_proxy_implementation.dart';
import 'package:git_ihm/domain/git/status/git_status_command.dart';
import 'package:git_ihm/model/git/git_file_status.dart';
import 'package:test/fake.dart';
import 'package:test/test.dart';

import '../mock/git_registry_mock.dart';
import '../mock/path_manager_mock.dart';

void main() {
  late GitRegistryMock registry;
  late PathManagerMock pathManager;
  late GitProxy testSubject;

  setUp(() {
    registry = GitRegistryMock();
    pathManager = PathManagerMock('');
    testSubject = GitProxyImplementation(registry, pathManager);
  });

  test('it delegates git --version to registry\'s GitVersionCommand', () async {
    expect(await testSubject.gitVersion(),
        same((await registry.versionCommand.run()).result));
  });

  test('it fetches path from pathManager', () {
    expect(testSubject.path, same(pathManager.path));
  });

  group('Spying on GitProxyImplementation behavior', () {
    late GitProxyImplementationSpy testSubject;

    setUp(() => testSubject = GitProxyImplementationSpy());

    test('it notifies listeners after getStatus', () async {
      await testSubject.updateStatus();
      expect(testSubject.listenersWhereNotified, equals(true));
    });

    test('it calls gitStatus with actual path on construct', () async {
      expect(testSubject.gitStatusCallCount, 1);
      expect(testSubject.gitStatusPathCalls, <String>[testSubject.actualPath]);
    });

    test('getStatus sets gitState with actual path gitStatus result', () async {
      testSubject.clearGitStatusCalls();
      await testSubject.updateStatus();

      expect(testSubject.gitStatusCallCount, 1);
      expect(testSubject.gitStatusPathCalls, <String>[testSubject.actualPath]);
      expect(testSubject.gitState, same(await testSubject.gitStatusResult));
    });
  });

  group('Spying on GitStatusCommand usage', () {
    late GitStatusCommandSpy statusCommandSpy;

    setUp(() {
      statusCommandSpy = GitStatusCommandSpy();
      registry.statusCommandMock = statusCommandSpy;
    });

    const String newPath = '/new/path';

    test('it delegates gitStatus method to GitStatusCommand', () async {
      final List<GitFileStatus> commandResult =
          await testSubject.gitStatus(newPath);
      expect(statusCommandSpy.pathProvidedToRun, same(newPath));
      expect(commandResult, same(statusCommandSpy.commandResult));
    });

    test('setting path updates path in pathManager', () {
      testSubject.path = newPath;
      expect(pathManager.path, equals(newPath));
    });

    test('When path is updated, it runs gitStatus command with new path', () {
      testSubject.path = newPath;
      expect(statusCommandSpy.pathProvidedToRun, equals(newPath));
    });
  });

  group('testing isGitDir against real directories', () {
    test('non git directories are detected', () async {
      expect(await testSubject.isGitDir('/tmp/git-ihm/nonGitProject'), false);
    });

    test('git directories are detected', () async {
      expect(await testSubject.isGitDir('/tmp/git-ihm/gitProject'), true);
    });
  }, tags: <String>['file-system-dependent']);
}

class GitProxyImplementationSpy extends GitProxyImplementation {
  GitProxyImplementationSpy() : super(GitRegistryMock(), PathManagerMock(''));

  bool listenersWhereNotified = false;
  int gitStatusCallCount = 0;
  List<String> gitStatusPathCalls = <String>[];
  String actualPath = '/mocked/path';

  Future<List<GitFileStatus>> gitStatusResult = Future<List<GitFileStatus>>(
      () => <GitFileStatus>[const UntrackedPath('any/path', 'any/path')]);

  @override
  String get path => actualPath;

  @override
  void notifyListeners() {
    listenersWhereNotified = true;
  }

  @override
  Future<List<GitFileStatus>> gitStatus(String path) {
    gitStatusCallCount++;
    gitStatusPathCalls.add(path);
    return gitStatusResult;
  }

  void clearGitStatusCalls() {
    gitStatusCallCount = 0;
    gitStatusPathCalls.clear();
  }
}

class GitStatusCommandSpy extends Fake implements GitStatusCommand {
  String? pathProvidedToRun;

  List<GitFileStatus> commandResult = <GitFileStatus>[
    const UntrackedPath('any/path', 'any/path')
  ];

  @override
  Future<CommandResult<List<GitFileStatus>>> run(String path) {
    pathProvidedToRun = path;
    return Future<CommandResult<List<GitFileStatus>>>(() =>
        CommandResult<List<GitFileStatus>>(
            commandResult, ProcessResult(0, 0, commandResult, null)));
  }
}
