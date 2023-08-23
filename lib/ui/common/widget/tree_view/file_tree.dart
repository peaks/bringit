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
import 'package:flutter/material.dart';
import 'package:flutter_treeview/flutter_treeview.dart';
import 'package:git_ihm/domain/git/git_proxy.dart';
import 'package:git_ihm/ui/common/file/file_tree/tree_data_file_loader.dart';
import 'package:git_ihm/ui/common/utils_factory.dart';
import 'package:git_ihm/ui/common/widget/tree_view/git_tree_node.dart';
import 'package:provider/provider.dart';

class FileTree extends StatefulWidget {
  const FileTree({Key? key}) : super(key: key);

  @override
  _FileTreeState createState() => _FileTreeState();
}

class _FileTreeState extends State<FileTree> {
  final bool _allowParentSelect = false;
  final bool _supportParentDoubleTap = false;

  late TreeDataFileLoader _fileLoader;
  late String _selectedNode = '';
  late TreeViewController _treeViewController;

  TreeViewController _initTreeViewController(String projectPath) {
    final List<Node<void>> childrenNode = <Node<void>>[];
    if (projectPath != '') {
      childrenNode.add(_fileLoader.getNode(projectPath));
    }

    return TreeViewController(
      children: childrenNode,
      selectedKey: _selectedNode,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _fileLoader =
        Provider.of<UtilsFactory>(context, listen: false).treeDataFileLoader;
    final GitProxy git = Provider.of<GitProxy>(context, listen: true);
    _fileLoader.status = git.gitState;
    _treeViewController = _initTreeViewController(git.path);
  }

  @override
  Widget build(BuildContext context) {
    final TreeViewTheme theme = _buildTreeViewTheme(context);
    final TreeView treeView = _buildTreeView(theme);
    return _buildTreeContainer(treeView);
  }

  TreeViewTheme _buildTreeViewTheme(BuildContext context) {
    return TreeViewTheme(
      expanderTheme: const ExpanderThemeData(
        animated: false,
        type: ExpanderType.chevron,
        position: ExpanderPosition.start,
        size: 20,
      ),
      labelStyle: _getLabelStyle(),
      parentLabelStyle: _getBoldLabelStyle(),
      iconTheme: IconThemeData(
        size: 18,
        color: Colors.grey.shade800,
      ),
      colorScheme: Theme.of(context).colorScheme,
      expandSpeed: const Duration(seconds: 0),
    );
  }

  TextStyle _getLabelStyle() =>
      const TextStyle(fontSize: 16, fontFamily: 'FantasqueSansMono');

  TextStyle _getBoldLabelStyle() =>
      _getLabelStyle().copyWith(fontWeight: FontWeight.bold);

  TreeView _buildTreeView(TreeViewTheme theme) {
    return TreeView(
        controller: _treeViewController,
        nodeBuilder: (BuildContext context, Node<void> node) =>
            GitTreeNode(node),
        allowParentSelect: _allowParentSelect,
        supportParentDoubleTap: _supportParentDoubleTap,
        onExpansionChanged: (String key, bool isExpanded) =>
            _toggleNodeState(key, isExpanded),
        onNodeTap: (String key) {
          setState(() {
            _selectedNode = (_selectedNode == key) ? '' : key;
            _treeViewController = _treeViewController.copyWith<dynamic>(
                selectedKey: _selectedNode);
          });
        },
        theme: theme,
        shrinkWrap: true);
  }

  void _toggleNodeState(String key, bool isExpanded) {
    final Node<void>? node = _treeViewController.getNode(key);
    if (node != null) {
      setState(() {
        _treeViewController = _treeViewController.copyWith(
            children: _updateNode(node, isExpanded));
      });
    }
  }

  List<Node<void>> _updateNode(Node<void> node, bool isExpanded) {
    return _treeViewController.updateNode(
        node.key,
        node.copyWith(
            children: _getNodeChildren(node.key, isExpanded),
            expanded: isExpanded));
  }

  List<Node<void>>? _getNodeChildren(String nodeKey, bool isExpanded) {
    return isExpanded ? _fileLoader.getNodes(nodeKey) : null;
  }

  TreeView _buildTreeContainer(TreeView treeView) {
    return treeView;
  }
}
