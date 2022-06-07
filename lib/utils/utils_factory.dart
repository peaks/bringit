import 'package:flutter/material.dart';

import 'file/icons/file_icondata.dart';
import 'file/tree/file_system_loader.dart';
import 'file/tree/file_system_node_mapper.dart';
import 'file/tree/tree_data_file_loader.dart';

class UtilsFactory {
  UtilsFactory() {
    fileSystemLoader = FileSystemLoader();
    iconFetcher = IconFetcher();
    nodeMapper = FileSystemNodeMapper(iconFetcher);
  }

  @protected
  late FileSystemLoader fileSystemLoader;
  @protected
  late IconFetcher iconFetcher;
  @protected
  late FileSystemNodeMapper nodeMapper;

  TreeDataFileLoader get treeDataFileLoader {
    return TreeDataFileLoader(fileSystemLoader, nodeMapper);
  }
}
