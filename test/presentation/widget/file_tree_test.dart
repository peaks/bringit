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
import 'package:git_ihm/presentation/widget/tree_view/file_tree.dart';

import '../../services/utils/file/tree/tree_data_file_loader_test.dart';
import '../../utils/git_dependent_loader.dart';

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
  final ScrollController _scrollController = ScrollController();

  await tester.pumpWidget(loader.loadAppWithWidget(Row(
    children: <Widget>[
      Expanded(
        child: Container(
          height: double.infinity,
          child: Scrollbar(
            controller: _scrollController,
            thumbVisibility: true,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              controller: _scrollController,
              child: const FileTree(),
            ),
          ),
        ),
      )
    ],
  )));
}
