import 'package:flutter/material.dart';
import 'package:flutter_treeview/flutter_treeview.dart';

class GitTreeNode extends StatelessWidget {
  const GitTreeNode(this.node, {Key? key}) : super(key: key);

  final Node<void> node;

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      Expanded(child: Icon(node.icon), flex: 1),
      Expanded(
        child: Text(node.label, style: TextStyle(color: node.iconColor)),
        flex: 3,
      )
    ]);
  }
}
