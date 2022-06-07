import 'dart:io';

import 'package:flutter_treeview/flutter_treeview.dart';
import 'package:git_ihm/utils/file/tree/file_system_loader.dart';
import 'package:git_ihm/utils/file/tree/file_system_node_mapper.dart';

import '../../../data/git/status_file.dart';

class TreeDataFileLoader {
  TreeDataFileLoader(this._fileSystem, this._mapper);

  final FileSystemLoader _fileSystem;
  final FileSystemNodeMapper _mapper;

  set status(List<StatusFile> gitStatus) {
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
