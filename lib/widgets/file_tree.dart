import 'package:flutter/material.dart';
import 'package:flutter_treeview/flutter_treeview.dart';
import 'package:git_ihm/utils/file/tree/load_file_tree_data.dart';

class FileTree extends StatefulWidget {
  const FileTree({Key? key, required this.path}) : super(key: key);
  final String path;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<FileTree> {
  late String _selectedNode = '';
  late TreeViewController _treeViewController;
  bool deepExpanded = true;
  final bool _allowParentSelect = false;
  final bool _supportParentDoubleTap = false;
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    _treeViewController = TreeViewController(
      children: <Node<void>>[
        Node<void>(
          key: 'root',
          expanded: true,
          label: widget.path,
          children: getNodesFromPath(widget.path),
        ),
      ],
      selectedKey: _selectedNode,
    );

    super.initState();
  }

  void _expandNode(String key, bool expanded) {
    final Node<void>? node = _treeViewController.getNode(key);
    if (node != null) {
      List<Node<void>> updated;
      updated = _treeViewController.updateNode(
          key, node.copyWith(expanded: expanded));
      setState(() {
        _treeViewController = _treeViewController.copyWith(children: updated);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final TreeViewTheme _treeViewTheme = TreeViewTheme(
      expanderTheme: const ExpanderThemeData(
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
    );
    return Container(
      height: double.infinity,
      child: Scrollbar(
        controller: _scrollController,
        isAlwaysShown: true,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          controller: _scrollController,
          child: TreeView(
              controller: _treeViewController,
              allowParentSelect: _allowParentSelect,
              supportParentDoubleTap: _supportParentDoubleTap,
              onExpansionChanged: (String key, bool expanded) {
                _expandNode(key, expanded);
              },
              onNodeTap: (String key) {
                setState(() {
                  if (_selectedNode == key) {
                    _selectedNode = '';
                  } else {
                    _selectedNode = key;
                  }
                  _treeViewController = _treeViewController.copyWith<dynamic>(
                      selectedKey: _selectedNode);
                });
              },
              theme: _treeViewTheme,
              shrinkWrap: true),
        ),
      ),
    );
  }
}
