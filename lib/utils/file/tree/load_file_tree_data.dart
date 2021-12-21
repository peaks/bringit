import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_treeview/flutter_treeview.dart';
import 'dart:developer';

List<Map<String, dynamic>> addToParentNode(List<Map<String, dynamic>> nodes,
    Map<String, dynamic> n, Iterable<String> pathToFile) {
  if (pathToFile.length > 0) {
    for (final Map<String, dynamic> node in nodes) {
      if (node['label'] == pathToFile.first) {
        node['children'] = addToParentNode(
            node['children'] as List<Map<String, dynamic>>,
            n,
            pathToFile.where((String element) => element != pathToFile.first));
      }
    }
  } else {
    nodes.add(n);
  }

  return nodes;
}

String getFileNameByUri(FileSystemEntity file) {
  if (file.uri.toString().contains('/')) {
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

List<Node<dynamic>> getDirFiles(String path, bool docsOpen) {
  // Create Dir object from existing path
  final Directory myDir = Directory(path);
  // List all file from dir
  final List<FileSystemEntity> allContent = myDir.listSync(recursive: true);
  // result
  List<Map<String, dynamic>> nodes = <Map<String, dynamic>>[];
  // loop items in path
  for (final FileSystemEntity file in allContent) {
    final Map<String, dynamic> n = <String, dynamic>{
      'label': getFileNameByUri(file),
      'key': file.uri.toString(),
      'children': <Map<String, dynamic>>[]
    };
    // file is located on root of tree
    if (file.parent.path == '.' || file.parent.path == './') {
      nodes.add(n);
    } else {
      final Iterable<String> pathToFile = n['key'].toString().split('/').where(
          (String element) => element.toString() != n['label'].toString());
      nodes = addToParentNode(nodes, n, pathToFile);
    }
  }
  log(nodes.toString());
  /*List<Node<dynamic>> nodes = [];
  
  
  // loop items in path
  for (final FileSystemEntity file in allContent) {
    // init Node
    Node<dynamic> n = Node<dynamic>(
      key: file.path.toString(),
      label: file.uri.toString(),
      icon: file.runtimeType.toString() == '_Directory'
          ? (docsOpen ? Icons.folder_open : Icons.folder)
          : (Icons.insert_drive_file), // TODO icon setter
      iconColor: Colors.blue,
    );

    if (file.parent.path == '.' || file.parent.path == './') {
      nodes.add(n);
    } else {
      // TODO
      Node<dynamic>? parent = findParent(file.parent.path, nodes);

      if (parent != null) {
        List<Node<dynamic>> children = parent.children.toList(growable: true);
        children.add(n);
        Node<dynamic> newParent = parent.copyWith(
            label: parent.label,
            key: parent.key,
            icon: parent.icon,
            iconColor: parent.iconColor,
            children: children);

        nodes.add(newParent);
      } else {
        log('Error : cannot find parent node');
        log('Error : ----------------------');
      }
    }
  }
*/
  //return nodes;
  return nodes;
}
