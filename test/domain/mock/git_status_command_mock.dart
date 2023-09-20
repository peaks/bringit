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
import 'package:git_ihm/domain/git/status/git_status_command.dart';
import 'package:git_ihm/model/git/git_file_status.dart';

class GitStatusCommandMock extends GitStatusCommand {
  List<GitFileStatus> mockedResult = <GitFileStatus>[];
  String expectedParameter = '';

  @override
  Future<List<GitFileStatus>> run(String path) async {
    if (path != expectedParameter) {
      throw Exception(
          'Failed asserting method "run" parameter: expecting "$expectedParameter", actual: "$path"');
    }
    return mockedResult;
  }

  void willReturn(List<GitFileStatus> list) {
    mockedResult = list;
  }

  GitStatusCommandMock withParameter(String gitPath) {
    expectedParameter = gitPath;

    return this;
  }
}
