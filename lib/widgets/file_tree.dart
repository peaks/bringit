import 'package:flutter/material.dart';
import 'package:flutter_treeview/flutter_treeview.dart';
import 'package:git_ihm/utils/file/tree/tree_data_file_loader.dart';
import 'package:git_ihm/utils/utils_factory.dart';
import 'package:provider/provider.dart';

import '../data/git_proxy.dart';

class FileTree extends StatefulWidget {
  const FileTree({Key? key}) : super(key: key);

  @override
  _FileTreeState createState() => _FileTreeState();
}

class _FileTreeState extends State<FileTree> {
  late GitProxy git;
  late TreeDataFileLoader fileLoader;

  late String _selectedNode = '';
  late TreeViewController _treeViewController;

  final bool _allowParentSelect = false;
  final bool _supportParentDoubleTap = false;
  bool deepExpanded = true;

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    final UtilsFactory factory =
        Provider.of<UtilsFactory>(context, listen: false);
    fileLoader = factory.treeDataFileLoader;

    super.initState();
  }

  @override
  void didChangeDependencies() {
    git = Provider.of<GitProxy>(context, listen: true);
    _initTreeViewController(git.path);

    super.didChangeDependencies();
  }

  void _initTreeViewController(String projectPath) {
    _treeViewController = TreeViewController(
      children: <Node<void>>[fileLoader.getNode(projectPath)],
      selectedKey: _selectedNode,
    );
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
      labelStyle: const TextStyle(
        fontSize: 16,
        fontFamily: 'FantasqueSansMono',
      ),
      parentLabelStyle: const TextStyle(
        fontFamily: 'FantasqueSansMono',
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
      iconTheme: IconThemeData(
        size: 18,
        color: Colors.grey.shade800,
      ),
      colorScheme: Theme.of(context).colorScheme,
      expandSpeed: const Duration(seconds: 0),
    );
  }

  TreeView _buildTreeView(TreeViewTheme theme) {
    return TreeView(
        controller: _treeViewController,
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

  void _toggleNodeState(String key, bool expandedState) {
    final Node<void>? node = _treeViewController.getNode(key);
    if (node == null) {
      return;
    }

    List<Node<void>>? nodeChildren;
    if (node.children.first.key == 'EMPTY_NODE') {
      nodeChildren = fileLoader.getNodes(node.key);
    }

    final List<Node<void>> updatedNode = _treeViewController.updateNode(
        node.key,
        node.copyWith(children: nodeChildren, expanded: expandedState));

    setState(() {
      _treeViewController = _treeViewController.copyWith(children: updatedNode);
    });
  }

  Expanded _buildTreeContainer(TreeView treeView) {
    return Expanded(
      child: Container(
        height: double.infinity,
        child: Scrollbar(
          controller: _scrollController,
          thumbVisibility: true,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            controller: _scrollController,
            child: treeView,
          ),
        ),
      ),
    );
  }
}
