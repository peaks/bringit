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
import 'package:git/git.dart';
import 'package:git_ihm/domain/path/path_manager.dart';
import 'package:git_ihm/model/git/git_commit.dart';
import 'package:git_ihm/model/git/git_file_status.dart';

import '../git/git_registry.dart';
import 'git_proxy.dart';

class GitProxyImplementation extends GitProxy {
  GitProxyImplementation(this._registry, this._pathManager) {
    getStatus();
  }

  final GitRegistry _registry;
  final PathManager _pathManager;

  @override
  Future<bool> isGitDir(String path) async {
    return await GitDir.isGitDir(path);
  }

  @override
  Future<List<GitFileStatus>> gitStatus(String path) async {
    return _registry.statusCommand.run(path);
  }

  @override
  Future<String> gitVersion() async {
    return _registry.versionCommand.run();
  }

  @override
  String get path => _pathManager.path;

  @override
  set path(String newPath) {
    _pathManager.path = newPath;
    getStatus();
  }

  @override
  Future<void> getStatus() async {
    gitState = await gitStatus(path);
    notifyListeners();
  }

  @override
  Future<List<GitCommit>> gitLog() async {
    return _registry.logCommand.run(path);
  }

  @override
  Future<String> gitInit(String directoryPath) {
    path = directoryPath;
    return _registry.initCommand.run(directoryPath);
  }
}
