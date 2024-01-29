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
import 'package:git_ihm/domain/git/git_proxy.dart';
import 'package:git_ihm/model/git/git_commit.dart';
import 'package:git_ihm/model/git/git_file_status.dart';

class GitProxyMock extends GitProxy {
  bool willFindGitDir = true;
  String _path = '/original/path';

  @override
  Future<bool> isGitDir(String path) async {
    return willFindGitDir;
  }

  @override
  Future<List<GitFileStatus>> gitStatus(String path) async {
    return <GitFileStatus>[];
  }

  @override
  Future<String> gitVersion() async {
    return '1.25.2';
  }

  @override
  Future<String> gitBranch(String path) async {
    return 'no branch';
  }

  @override
  String get path => _path;

  @override
  set path(String newPath) {
    _path = newPath;
    notifyListeners();
  }

  @override
  Future<void> updateStatus() async {
    gitState = <GitFileStatus>[];
    // notifyListeners();
  }

  @override
  Future<List<GitCommit>> gitLog() async {
    return <GitCommit>[];
  }

  @override
  Future<String> gitInit(String diretoryPath) async {
    return 'no init';
  }

  @override
  Future<String> gitAddAll(String path) async {
    return 'no path';
  }

  @override
  Future<String> gitAdd(String filePath, String path) async {
    return 'no path';
  }

  @override
  Future<String> gitRestoreStaged(String filePath, String path) async {
    return 'no path';
  }

  @override
  Future<String> gitRestoreStagedAll(String path) async {
    return 'no path';
  }

  @override
  Future<String> gitCommit(String messageCommit, String path) async {
    return 'no path';
  }

  @override
  Future<String> gitGetConfigUserName(String path) async {
    return 'no user name';
  }

  @override
  Future<String> gitGetConfigUserEmail(String path) async {
    return 'no user email';
  }
}
