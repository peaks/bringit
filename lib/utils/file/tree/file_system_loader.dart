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
import 'dart:io';

class FileSystemLoader {
  List<FileSystemEntity> list(Directory dir) {
    if (!dir.existsSync()) {
      throw const FileSystemException('No a valid directory');
    }

    return _sortByNamesDirectoriesFirst(dir.listSync());
  }

  List<FileSystemEntity> _sortByNamesDirectoriesFirst(
      List<FileSystemEntity> content) {
    content.sort((FileSystemEntity a, FileSystemEntity b) {
      if (a is Directory && b is! Directory) {
        return -1;
      }

      if (a is! Directory && b is Directory) {
        return 1;
      }

      return a.path.compareTo(b.path);
    });

    return content;
  }
}
