import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_treeview/flutter_treeview.dart';
import 'package:git_ihm/utils/file/icons/file_icondata.dart';
import 'package:path/path.dart';

const Node<void> EMPTY_NODE = Node<void>(key: 'EMPTY_NODE', label: '');

Node<void> getNodeFromPath(String path) {
  final Directory directory = Directory(path);
  final String absolutePath = directory.absolute.path;
  return Node<void>(
    key: absolutePath,
    expanded: true,
    label: basename(absolutePath),
    children: getNodesFromPath(absolutePath),
  );
}

List<Node<void>> getNodesFromPath(String path) {
  final Directory directory = Directory(path);
  final List<FileSystemEntity> allContent =
      directory.listSync(recursive: false);

  final List<Node<void>> nodes = <Node<void>>[];

  for (final FileSystemEntity file in allContent) {
    final Node<void> node = Node<void>(
      key: file.absolute.path,
      icon: file is Directory ? Icons.folder : getIconDataForFile(file.path),
      iconColor: Colors.white,
      label: basename(file.path),
      children: file is Directory ? <Node<void>>[EMPTY_NODE] : <Node<void>>[],
    );

    nodes.add(node);
  }
  nodes.sort((Node<void> a, Node<void> b) => (a.key).compareTo(b.key));

  return nodes;
}
