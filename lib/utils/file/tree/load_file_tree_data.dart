import 'dart:io';

import 'package:flutter_treeview/flutter_treeview.dart';
import 'package:path/path.dart';

List<Node<void>> getNodesFromPath(String path) {
  final Directory directory = Directory(path);
  final List<FileSystemEntity> allContent =
      directory.listSync(recursive: false);

  final List<Node<void>> nodes = <Node<void>>[];

  for (final FileSystemEntity file in allContent) {
    final Node<void> node = Node<void>(
      key: file.absolute.path,
      label: basename(file.path),
      children: file is Directory
          ? getNodesFromPath(file.absolute.path)
          : <Node<void>>[],
    );

    nodes.add(node);
  }
  nodes.sort((Node<void> a, Node<void> b) => (a.key).compareTo(b.key));

  return nodes;
}
