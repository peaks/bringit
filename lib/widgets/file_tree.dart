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
  final bool _allowParentSelect = false;
  final bool _supportParentDoubleTap = false;
  final ScrollController _scrollController = ScrollController();

  late TreeDataFileLoader _fileLoader;
  late String _selectedNode = '';
  late TreeViewController _treeViewController;

  TreeViewController _initTreeViewController(String projectPath) {
    return TreeViewController(
      children: <Node<void>>[_fileLoader.getNode(projectPath)],
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
