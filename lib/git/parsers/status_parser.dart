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

class StatusParser {
  static const String GIT_RENAMED = 'R ';

  String _projectPath = '';

  void setProject(String prefix) {
    if (prefix.endsWith(separator)) {
      _projectPath = prefix;
      return;
    }
    _projectPath = prefix + separator;
  }

  StatusFile parse(String fileStatus) {
    final String gitPrefix = fileStatus.substring(0, 2);
    final String filePath =
        _projectPath + _extractFilePath(gitPrefix, fileStatus);

    switch (gitPrefix) {
      case '??':
        return UntrackedPath(filePath);
      case ' M':
        return ModifiedFile(filePath);
      case 'A ':
      case 'M ':
        return AddedFile(filePath);
      case '!!':
        return IgnoredFile(filePath);
      case GIT_RENAMED:
        return RenamedFile(filePath);
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
    if (gitPrefix == GIT_RENAMED) {
      return _extractNewName(gitStatusLine);
    }

    return _cutFirstThreeCharacters(gitStatusLine);
  }
}
