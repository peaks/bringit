import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_treeview/flutter_treeview.dart';
import 'dart:developer';

class FileTree extends StatefulWidget {
  const FileTree({Key? key, required this.path}) : super(key: key);
  final String path;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<FileTree> {
  late String _selectedNode = 'd3'; // TODO init
  List<Node<dynamic>> _nodes = []; // TODO set state with value
  late TreeViewController _treeViewController;
  bool docsOpen = true;
  bool deepExpanded = true;
  // ignore: always_specify_types
  final Map<ExpanderPosition, Widget> expansionPositionOptions = const {
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

  List<Node<dynamic>> dirContents(String path) {
    List<Node<dynamic>> nodes = [];
    // Create Dir object from existing path
    final Directory myDir = Directory(path);
    // List all file from dir
    final List<FileSystemEntity> allContent = myDir.listSync(recursive: true);
    // loop items in path
    for (final FileSystemEntity file in allContent) {
      // init Node
      final Node<dynamic> n = Node<dynamic>(
        key: file.path.toString(),
        label: file.path.toString(),
        icon: file.runtimeType.toString() == '_Directory'
            ? (docsOpen ? Icons.folder_open : Icons.folder)
            : (Icons.insert_drive_file), // TODO icon setter
        iconColor: Colors.blue,
      );
      nodes.add(n);
      /*log(file.absolute.runtimeType.toString()); // _Directory / _File
      log(file.path.toString());
      log(file.parent.path.toString());
      log(file.uri.toString());
      log('---------------------');*/

      //nodes.add(Node(key: file.path, label: ))
      //label: 'personal',
      //key: 'd3',
      //icon: Icons.input,
      //iconColor: Colors.red,
      //children: <Node<dynamic>>[
    }

    return nodes;
  }

  @override
  void initState() {
    // get files from path
    final List<Node<dynamic>> _nodes = dirContents(widget.path);
    /*
    final List<Node<dynamic>> _nodes = <Node<dynamic>>[
      Node<dynamic>(
        label: 'documents',
        key: 'docs',
        expanded: docsOpen,
        icon: docsOpen ? Icons.folder_open : Icons.folder,
        children: <Node<dynamic>>[
          const Node<dynamic>(
            label: 'personal',
            key: 'd3',
            icon: Icons.input,
            iconColor: Colors.red,
            children: <Node<dynamic>>[
              Node<dynamic>(
                label: 'Poems.docx',
                key: 'pd1',
                icon: Icons.insert_drive_file,
              ),
              Node<dynamic>(
                label: 'Job Hunt',
                key: 'jh1',
                icon: Icons.input,
                children: <Node<dynamic>>[
                  Node<dynamic>(
                    label: 'Resume.docx',
                    key: 'jh1a',
                    icon: Icons.insert_drive_file,
                  ),
                  Node<dynamic>(
                    label: 'Cover Letter.docx',
                    key: 'jh1b',
                    icon: Icons.insert_drive_file,
                  ),
                ],
              ),
            ],
          ),
          const Node<dynamic>(
            label: 'Inspection.docx',
            key: 'd1',
//          icon: Icons.insert_drive_file),
          ),
          const Node<dynamic>(
              label: 'Invoice.docx', key: 'd2', icon: Icons.insert_drive_file),
        ],
      ),
      const Node<dynamic>(
          label: 'MeetingReport.xls',
          key: 'mrxls',
          icon: Icons.insert_drive_file),
      Node<dynamic>(
          label: 'MeetingReport.pdf',
          key: 'mrpdf',
          iconColor: Colors.green.shade300,
          selectedIconColor: Colors.white,
          icon: Icons.insert_drive_file),
      const Node<dynamic>(label: 'Demo.zip', key: 'demo', icon: Icons.archive),
      const Node<dynamic>(
        label: 'empty folder',
        key: 'empty',
        parent: true,
      ),
    ];
*/
    // controller
    _treeViewController = TreeViewController(
      children: _nodes,
      selectedKey: _selectedNode,
    );
    // call parent init state
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
                    onExpansionChanged: (String key, bool expanded) =>
                        _expandNode(key, expanded),
                    onNodeTap: (String key) {
                      debugPrint('Selected: $key');
                      setState(() {
                        _selectedNode = key;
                        _treeViewController = _treeViewController
                            .copyWith<dynamic>(selectedKey: key);
                      });
                    },
                    theme: _treeViewTheme,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _expandNode(String key, bool expanded) {
    final String msg = '${expanded ? "Expanded" : "Collapsed"}: $key';
    debugPrint(msg);
    final Node<dynamic>? node = _treeViewController.getNode<dynamic>(key);
    if (node != null) {
      List<Node<dynamic>> updated;
      if (key == 'docs') {
        updated = _treeViewController.updateNode<dynamic>(
            key,
            node.copyWith(
              expanded: expanded,
              icon: expanded ? Icons.folder_open : Icons.folder,
            ));
      } else {
        updated = _treeViewController.updateNode<dynamic>(
            key, node.copyWith(expanded: expanded));
      }
      setState(() {
        // ignore: always_put_control_body_on_new_line
        if (key == 'docs') docsOpen = expanded;
        _treeViewController =
            _treeViewController.copyWith<dynamic>(children: updated);
      });
    }
  }
}

class ModContainer extends StatelessWidget {
  final ExpanderModifier modifier;

  // ignore: sort_constructors_first
  const ModContainer({Key? key, required this.modifier}) : super(key: key);

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
