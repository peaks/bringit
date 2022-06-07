import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_treeview/flutter_treeview.dart';
import 'package:git_ihm/screen/shared/git_tree_node.dart';

void main() {
  late Node<void> nodeSource;

  setUp(() {
    nodeSource = _buildNode();
  });

  testWidgets('it displays node label', (WidgetTester tester) async {
    await _generateGitTreeNodeInApp(nodeSource, tester);
    expect(find.text(nodeSource.label), findsOneWidget);
  });

  testWidgets('it displays node icon', (WidgetTester tester) async {
    await _generateGitTreeNodeInApp(nodeSource, tester);
    expect(find.byIcon(nodeSource.icon!), findsOneWidget);
  });

  testWidgets('it displays text with node color', (WidgetTester tester) async {
    await _generateGitTreeNodeInApp(nodeSource, tester);
    final Text resultLabel =
        find.text(nodeSource.label).evaluate().first.widget as Text;
    expect(resultLabel.style!.color, nodeSource.iconColor);
  });
}

Future<void> _generateGitTreeNodeInApp(
    Node<void> node, WidgetTester tester) async {
  final Widget app = MaterialApp(home: Material(child: GitTreeNode(node)));
  await tester.pumpWidget(app);
}

Node<void> _buildNode() {
  return const Node<void>(
    key: '/foo/bar/anyName',
    label: 'anyName',
    icon: Icons.folder,
    iconColor: Colors.red,
  );
}
