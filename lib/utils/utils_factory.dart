import 'package:flutter/material.dart';

import 'file/icons/file_icondata.dart';
import 'file/tree/file_system_loader.dart';
import 'file/tree/file_system_node_mapper.dart';
import 'file/tree/tree_data_file_loader.dart';

class UtilsFactory {
  @protected
  FileSystemLoader fileSystemLoader = FileSystemLoader();
  @protected
  IconFetcher iconFetcher = IconFetcher();

  TreeDataFileLoader get treeDataFileLoader {
    return TreeDataFileLoader(
        fileSystemLoader, FileSystemNodeMapper(iconFetcher));
  }
}
