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

import 'package:flutter_treeview/flutter_treeview.dart';
import 'package:git_ihm/ui/common/file/file_tree/file_system_loader.dart';
import 'package:git_ihm/ui/common/file/file_tree/file_system_node_mapper.dart';

import '../../../../model/git/git_file_status.dart';

class TreeDataFileLoader {
  TreeDataFileLoader(this._fileSystem, this._mapper);

  final FileSystemLoader _fileSystem;
  final FileSystemNodeMapper _mapper;

  set status(List<GitFileStatus> gitStatus) {
    _mapper.status = gitStatus;
  }

  List<Node<void>> getNodes(String path) {
    final List<Node<void>> nodes = <Node<void>>[];
    for (final FileSystemEntity file in _fileSystem.list(Directory(path))) {
      nodes.add(_mapper.map(file));
    }

    return nodes;
  }

  Node<void> getNode(String path) {
    final Node<void> parentNode = _mapper.map(Directory(path));

    return parentNode.copyWith(expanded: true, children: getNodes(path));
  }
}
