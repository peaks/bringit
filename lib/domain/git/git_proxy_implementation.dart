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

import 'package:git/git.dart';
import 'package:git_ihm/domain/git/base_command/command_result.dart';
import 'package:git_ihm/domain/path/path_manager.dart';
import 'package:git_ihm/helpers/git_gud_logger.dart';
import 'package:git_ihm/model/git/git_commit.dart';
import 'package:git_ihm/model/git/git_file_status.dart';
import 'package:logger/logger.dart';

import '../git/git_registry.dart';
import 'git_proxy.dart';

class GitProxyImplementation extends GitProxy {
  GitProxyImplementation(this._registry, this._pathManager) {
    updateStatus();

    _log = getLogger(runtimeType.toString());
  }

  final GitRegistry _registry;
  final PathManager _pathManager;
  late Logger _log;

  @override
  Future<bool> isGitDir(String path) async {
    return await GitDir.isGitDir(path);
  }

  @override
  Future<List<GitFileStatus>> gitStatus(String path) async {
    final CommandResult<List<GitFileStatus>> commandResult =
        await _registry.statusCommand.run(path);
    if (commandResult.isSuccessful) {
      return commandResult.result;
    }
    throw Exception(
        'Command git status failed to execute: ${commandResult.stderr}');
  }

  @override
  Future<String> gitVersion() async {
    final CommandResult<String> commandResult =
        await _registry.versionCommand.run();
    if (commandResult.isSuccessful) {
      return commandResult.result;
    }
    throw Exception(
        'Command git version failed to execute: ${commandResult.stderr}');
  }

  @override
  String get path => _pathManager.path;

  @override
  set path(String newPath) {
    _pathManager.path = newPath;
    updateStatus();
    notifyListeners();
  }

  @override
  Future<String> gitAddAll(String path) async {
    final CommandResult<String> commandResult =
        await _registry.addAllCommand.run(path);
    if (commandResult.isSuccessful) {
      return commandResult.result;
    }
    throw Exception(
        'Command git add all failed to execute: ${commandResult.stderr}');
  }

  @override
  Future<String> gitAdd(String fileRelativePath, String path) async {
    final CommandResult<String> commandResult =
        await _registry.addCommand.run(fileRelativePath, path);
    if (commandResult.isSuccessful) {
      return commandResult.result;
    }
    throw Exception(
        'Command git add failed to execute: ${commandResult.stderr}');
  }

  @override
  Future<String> gitRestoreStagedAll(String path) async {
    final CommandResult<String> commandResult =
        await _registry.restoreStagedAllCommand.run(path);
    if (commandResult.isSuccessful) {
      return commandResult.result;
    }
    throw Exception(
        'Command git restore staged all failed to execute: ${commandResult.stderr}');
  }

  @override
  Future<String> gitRestoreStaged(String fileRelativePath, String path) async {
    final CommandResult<String> commandResult =
        await _registry.restoreStagedCommand.run(fileRelativePath, path);
    if (commandResult.isSuccessful) {
      return commandResult.result;
    }
    throw Exception(
        'Command git restore staged failed to execute: ${commandResult.stderr}');
  }

  @override
  Future<void> updateStatus() async {
    gitState = await gitStatus(path);
    notifyListeners();
  }

  @override
  Future<List<GitCommit>> gitLog() async {
    final CommandResult<List<GitCommit>> commandResult =
        await _registry.logCommand.run(path);
    if (commandResult.isSuccessful) {
      return commandResult.result;
    }
    throw Exception(
        'Command git log failed to execute: ${commandResult.stderr}');
  }

  @override
  Future<String> gitInit(String directoryPath) async {
    final Directory repositoryDirectory = Directory(directoryPath);
    try {
      await repositoryDirectory.create(recursive: true);
      final CommandResult<String> initStatus =
          await _registry.initCommand.run(directoryPath);
      if (await GitDir.isGitDir(directoryPath)) {
        path = directoryPath;
        notifyListeners();
        _log.i("git project '$repositoryDirectory' successfully created");
        return initStatus.result;
      } else {
        throw Exception('Error: Git initialization failed');
      }
    } catch (e) {
      throw Exception(
          'Error: Unable to create the directory or initialize Git.');
    }
  }
}
