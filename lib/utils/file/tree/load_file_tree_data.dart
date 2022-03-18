import 'dart:io';

import 'package:flutter_treeview/flutter_treeview.dart';
import 'package:path/path.dart';

/// get name of a file by uri
String getFileNameByUri(FileSystemEntity file) {
  if (file.absolute.path.toString().contains('/')) {
    final List<String> temp = file.uri.toString().split('/');
    if (temp.isNotEmpty && temp.last != '') {
      return temp.last;
    } else {
      return temp.first;
    }
  } else {
    return file.uri.toString();
  }
}

List<Node<void>> getNodesFromPath(String path, bool docsOpen) {
  /// List all file from dir
  final Directory directory = Directory(path);
  final List<FileSystemEntity> allContent =
      directory.listSync(recursive: false);

  /// result
  final List<Node<void>> nodes = <Node<void>>[];

  /// loop items in path
  for (final FileSystemEntity file in allContent) {
    final Node<void> node = Node<void>(
      key: file.absolute.path,
      label: basename(file.path),
      children: file is Directory
          ? getNodesFromPath(file.absolute.path, docsOpen)
          : <Node<void>>[],
    );

    nodes.add(node);
  }
  //nodes.sort((Node<void> a, Node<void> b) => (a.key).compareTo(b.key));

  return nodes;
}
