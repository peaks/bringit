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

import 'package:flutter/material.dart';
import 'package:flutter_treeview/flutter_treeview.dart';
import 'package:git_ihm/data/git/status_file.dart';
import 'package:path/path.dart';

import '../icons/file_icondata.dart';

class FileSystemNodeMapper {
  FileSystemNodeMapper(this._iconFetcher);

  final Map<String, StatusFile> _status = <String, StatusFile>{};

  final IconFetcher _iconFetcher;

  set status(List<StatusFile> files) {
    _status.clear();
    for (final StatusFile element in files) {
      _status[element.fileAbsolutePath] = element;
    }
  }

  Node<void> map(FileSystemEntity entity) {
    return Node<void>(
      key: entity.absolute.path,
      label: basename(entity.path),
      icon: _fetchIcon(entity),
      iconColor: _fetchIconColor(entity),
      children: _setChildren(entity),
    );
  }

  Color _fetchIconColor(FileSystemEntity entity) {
    final String entityPath = entity.absolute.path;
    if (_status.containsKey(entityPath)) {
      return _status[entityPath]!.color;
    }

    if (_findParentUntrackedPath(entityPath).isNotEmpty) {
      return Colors.red;
    }

    return Colors.white;
  }

  Map<String, StatusFile> _findParentUntrackedPath(String absolutePath) {
    final Map<String, StatusFile> untrackedPath =
        Map<String, StatusFile>.from(_status);

    untrackedPath.removeWhere((String key, StatusFile value) =>
        !(value is UntrackedPath && absolutePath.startsWith(key)));

    return untrackedPath;
  }

  IconData _fetchIcon(FileSystemEntity entity) {
    if (entity is Directory) {
      return Icons.folder;
    }

    return _iconFetcher.getIcon(entity.path);
  }

  List<Node<void>> _setChildren(FileSystemEntity entity) {
    final List<Node<void>> children = <Node<void>>[];
    if (entity is Directory) {
      children.add(const Node<void>(key: 'EMPTY_NODE', label: ''));
    }

    return children;
  }
}
