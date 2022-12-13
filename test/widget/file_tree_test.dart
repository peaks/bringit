import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_treeview/flutter_treeview.dart';
import 'package:git_ihm/widget/file_tree.dart';

import '../git_dependent_loader.dart';
import '../utils/file/tree/tree_data_file_loader_test.dart';

final GitDependentLoader loader = GitDependentLoader();
final FakeUtilsFactory mockedFactory = FakeUtilsFactory();
late FakeFileSystemLoader mockedFileSystem = FakeFileSystemLoader();

void main() {
  setUp(() {
    mockedFileSystem = FakeFileSystemLoader();
  });

  testWidgets('it displays a TreeView', (WidgetTester tester) async {
    await loadFileTreeInTestApp(tester);

    expect(find.byType(TreeView), findsOneWidget);
  });
}

Future<void> loadFileTreeInTestApp(WidgetTester tester) async {
  mockedFactory.setFileSystemLoader(mockedFileSystem);
  loader.utilsFactory = mockedFactory;

  await tester.pumpWidget(loader.loadAppWithWidget(Row(
    children: const <Widget>[FileTree()],
  )));
}
