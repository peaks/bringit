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
import 'package:path/path.dart';

import '../../data/git/status_file.dart';

//
class StatusParser {
  // ' M' is modified but unstaged
  // 'M ' is modified and staged file
  // 'MM' is modified then staged then modified again. The second modification
  // is not staged yet
  // ' D' is deleted but unstaged
  // 'D ' is deleted and staged file
  // ' R' is renamed but unstaged
  // 'R ' is renamed and staged file
  // 'RM' is renamed and staged then modified file. The modification are not
  // staged => file staged as renames ans unstaged as modified
  // 'A ' is new file not modified but staged
  // 'AM' is new file with modification staged
  // '??' is new file but not known by git so untracked
  static const String GIT_UNTRACKED = '??';
  static const String GIT_RENAMED = 'R ';
  static const String GIT_RENAMED_UNSTAGED = ' R';
  static const String GIT_RENAMED_MODIFIED = 'RM';
  static const String GIT_MODIFIED = 'M ';
  static const String GIT_MODIFIED_UNSTAGED = ' M';
  //
  static const String GIT_MODIFIED_STAGED_THEN_MODIFIED = 'MM';
  static const String GIT_ADDED = 'A ';
  static const String GIT_ADDED_MODIFIED = 'AM';
  static const String GIT_DELETED = 'D ';
  static const String GIT_DELETED_UNSTAGED = ' D';

  String _projectPath = '';

  void setProject(String prefix) {
    if (prefix.endsWith(separator)) {
      _projectPath = prefix;
      return;
    }
    _projectPath = prefix + separator;
  }

  List<StatusFile> parse(String fileStatus) {
    final String gitPrefix = fileStatus.substring(0, 2);
    final String fileRelativePath = _extractFilePath(gitPrefix, fileStatus);
    final String fileAbsolutePath = _projectPath + fileRelativePath;
    switch (gitPrefix) {
      case GIT_RENAMED_MODIFIED:
        return <StatusFile>[
          RenamedFile(
              fileAbsolutePath, fileRelativePath, GitDiffFileState.staged),
          ModifiedFile(
              fileAbsolutePath, fileRelativePath, GitDiffFileState.unstaged)
        ];
      case GIT_MODIFIED_STAGED_THEN_MODIFIED:
        return <StatusFile>[
          ModifiedFile(
              fileAbsolutePath, fileRelativePath, GitDiffFileState.unstaged),
          ModifiedFile(
              fileAbsolutePath, fileRelativePath, GitDiffFileState.staged)
        ];
      case GIT_UNTRACKED:
        return <StatusFile>[UntrackedPath(fileAbsolutePath, fileRelativePath)];
      case GIT_MODIFIED_UNSTAGED:
        return <StatusFile>[
          ModifiedFile(
              fileAbsolutePath, fileRelativePath, GitDiffFileState.unstaged)
        ];
      case GIT_MODIFIED:
        return <StatusFile>[
          ModifiedFile(
              fileAbsolutePath, fileRelativePath, GitDiffFileState.staged)
        ];
      case GIT_ADDED:
      case GIT_ADDED_MODIFIED:
        return <StatusFile>[
          AddedFile(fileAbsolutePath, fileRelativePath, GitDiffFileState.staged)
        ];
      case GIT_DELETED:
        return <StatusFile>[
          DeletedFile(
              fileAbsolutePath, fileRelativePath, GitDiffFileState.staged)
        ];
      case GIT_DELETED_UNSTAGED:
        return <StatusFile>[
          DeletedFile(
              fileAbsolutePath, fileRelativePath, GitDiffFileState.unstaged)
        ];
      case GIT_RENAMED:
        return <StatusFile>[
          RenamedFile(
              fileAbsolutePath, fileRelativePath, GitDiffFileState.staged)
        ];
      case GIT_RENAMED_UNSTAGED:
        return <StatusFile>[
          RenamedFile(
              fileAbsolutePath, fileRelativePath, GitDiffFileState.unstaged)
        ];
      default:
        throw Exception('Unexpected prefix "$gitPrefix"');
    }
  }

  String _extractNewName(String fileStatus) {
    final List<String> pathElements = fileStatus.split('->');
    return pathElements[1].trim();
  }

  String _cutFirstThreeCharacters(String fileStatus) => fileStatus.substring(3);

  String _extractFilePath(String gitPrefix, String gitStatusLine) {
    if (gitPrefix == GIT_RENAMED_UNSTAGED ||
        gitPrefix == GIT_RENAMED_MODIFIED) {
      return _extractNewName(gitStatusLine);
    }

    return _cutFirstThreeCharacters(gitStatusLine);
  }
}
