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
import 'package:flutter/cupertino.dart';
import 'package:git_ihm/model/git/git_commit.dart';
import 'package:git_ihm/model/git/git_file_status.dart';

abstract class GitProxy extends ChangeNotifier {
  Future<bool> isGitDir(String path);

  Future<List<GitFileStatus>> gitStatus(String path);

  Future<String> gitVersion();

  String get path;

  set path(String newPath);

  List<GitFileStatus> gitState = <GitFileStatus>[];

  Future<void> getStatus();

  Future<List<GitCommit>> gitLog();
}
