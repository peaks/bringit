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
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:git_ihm/utils/file/icons/data.dart';

/*
 * File IconData for Flutter, inspired from https://github.com/git-touch/file-icon
 */

IconData getIconDataForFile(String fileName) {
  String key = '.txt';

  if (iconSetMap.containsKey(fileName)) {
    key = fileName;
  } else {
    List<String> chunks = fileName.split('.').sublist(1);
    while (chunks.isNotEmpty) {
      final String chunk = '.' + chunks.join();
      if (iconSetMap.containsKey(chunk)) {
        key = chunk;
        break;
      }
      chunks = chunks.sublist(1);
    }
  }

  return IconData(
    iconSetMap[key]?.codePoint ?? 0,
    fontFamily: 'Seti',
  );
}

class IconFetcher {
  IconData getIcon(String fileName) {
    return getIconDataForFile(fileName);
  }
}
