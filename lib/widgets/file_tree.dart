import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_treeview/flutter_treeview.dart';
import 'package:git_ihm/utils/file/tree/load_file_tree_data.dart';

/// package : flutter_treeview_example
/// doc-url : https://bitbucket.org/kevinandre/flutter_treeview_example/src/master/
class FileTree extends StatefulWidget {
  const FileTree({Key? key, required this.path}) : super(key: key);
  final String path;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<FileTree> {
  late String _selectedNode = '';
  late TreeViewController _treeViewController;
  bool docsOpen = true;
  bool deepExpanded = true;
  final Map<ExpanderPosition, Widget> expansionPositionOptions =
      const <ExpanderPosition, Text>{
    ExpanderPosition.start: Text('Start'),
    ExpanderPosition.end: Text('End'),
  };
  final Map<ExpanderType, Widget> expansionTypeOptions = <ExpanderType, Widget>{
    ExpanderType.none: Container(),
    ExpanderType.caret: const Icon(
      Icons.arrow_drop_down,
      size: 28,
    ),
    ExpanderType.arrow: const Icon(Icons.arrow_downward),
    ExpanderType.chevron: const Icon(Icons.expand_more),
    ExpanderType.plusMinus: const Icon(Icons.add),
  };
  final Map<ExpanderModifier, Widget> expansionModifierOptions =
      <ExpanderModifier, Widget>{
    ExpanderModifier.none: const ModContainer(modifier: ExpanderModifier.none),
    ExpanderModifier.circleFilled:
        const ModContainer(modifier: ExpanderModifier.circleFilled),
    ExpanderModifier.circleOutlined:
        const ModContainer(modifier: ExpanderModifier.circleOutlined),
    ExpanderModifier.squareFilled:
        const ModContainer(modifier: ExpanderModifier.squareFilled),
    ExpanderModifier.squareOutlined:
        const ModContainer(modifier: ExpanderModifier.squareOutlined),
  };
  final bool _allowParentSelect = false;
  final bool _supportParentDoubleTap = false;

  @override
  void initState() {
    /// controller
    _treeViewController = TreeViewController(
      children: <Node<dynamic>>[],
      selectedKey: _selectedNode,
    );
    _treeViewController = _treeViewController.loadJSON<dynamic>(
        json: jsonEncode(getDirFiles(widget.path, docsOpen)));

    /// call parent init state
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final TreeViewTheme _treeViewTheme = TreeViewTheme(
      expanderTheme: const ExpanderThemeData(
          type: ExpanderType.arrow,
          modifier: ExpanderModifier.none,
          position: ExpanderPosition.start,
          // color: Colors.grey.shade800,
          size: 20,
          color: Colors.blue),
      labelStyle: const TextStyle(
        fontSize: 16,
        letterSpacing: 0.3,
      ),
      parentLabelStyle: TextStyle(
        fontSize: 16,
        letterSpacing: 0.1,
        fontWeight: FontWeight.w800,
        color: Colors.blue.shade700,
      ),
      iconTheme: IconThemeData(
        size: 18,
        color: Colors.grey.shade800,
      ),
      colorScheme: Theme.of(context).colorScheme,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('Files in ${widget.path}'),
        elevation: 0,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
          padding: const EdgeInsets.all(20),
          height: double.infinity,
          child: Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(10),
                  child: TreeView(
                      controller: _treeViewController,
                      allowParentSelect: _allowParentSelect,
                      supportParentDoubleTap: _supportParentDoubleTap,
                      onExpansionChanged: (String key, bool expanded) {
                        setState(() {
                          docsOpen = expanded;
                        });
                      },
                      onNodeTap: (String key) {
                        debugPrint('Selected: $key');
                        setState(() {
                          _selectedNode = key;
                          _treeViewController = _treeViewController
                              .copyWith<dynamic>(selectedKey: key);
                        });
                      },
                      theme: _treeViewTheme,
                      shrinkWrap: true),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ModContainer extends StatelessWidget {
  /// constructor
  const ModContainer({Key? key, required this.modifier}) : super(key: key);

  /// modifier
  final ExpanderModifier modifier;
  @override
  Widget build(BuildContext context) {
    double _borderWidth = 0;
    BoxShape _shapeBorder = BoxShape.rectangle;
    Color _backColor = Colors.transparent;
    final Color _backAltColor = Colors.grey.shade700;
    switch (modifier) {
      case ExpanderModifier.none:
        break;
      case ExpanderModifier.circleFilled:
        _shapeBorder = BoxShape.circle;
        _backColor = _backAltColor;
        break;
      case ExpanderModifier.circleOutlined:
        _borderWidth = 1;
        _shapeBorder = BoxShape.circle;
        break;
      case ExpanderModifier.squareFilled:
        _backColor = _backAltColor;
        break;
      case ExpanderModifier.squareOutlined:
        _borderWidth = 1;
        break;
    }
    return Container(
      decoration: BoxDecoration(
        shape: _shapeBorder,
        border: _borderWidth == 0
            ? null
            : Border.all(
                width: _borderWidth,
                color: _backAltColor,
              ),
        color: _backColor,
      ),
      width: 15,
      height: 15,
    );
  }
}
