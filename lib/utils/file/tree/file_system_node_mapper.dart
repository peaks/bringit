import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_treeview/flutter_treeview.dart';
import 'package:path/path.dart';

import '../icons/file_icondata.dart';

class FileSystemNodeMapper {
  FileSystemNodeMapper(this._iconFetcher);

  final IconFetcher _iconFetcher;

  Node<void> map(FileSystemEntity entity) {
    return Node<void>(
      key: entity.absolute.path,
      label: basename(entity.path),
      icon: _fetchIcon(entity),
      iconColor: Colors.white,
      children: _setChildren(entity),
    );
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
