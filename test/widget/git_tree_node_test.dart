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
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_treeview/flutter_treeview.dart';
import 'package:git_ihm/widget/git_tree_node.dart';

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
