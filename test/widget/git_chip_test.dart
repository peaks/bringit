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
import 'package:flutter_test/flutter_test.dart';
import 'package:git_ihm/data/git_proxy.dart';
import 'package:git_ihm/widget/git_chip.dart';

import '../git_dependent_loader.dart';
import '../mock/git_proxy_mock.dart';

void main() {
  testWidgets('it displays fetching message on loading',
      (WidgetTester tester) async {
    final GitDependentLoader loader = GitDependentLoader();
    await tester.pumpWidget(loader.loadAppWithWidget(const GitChip()));

    expect(find.text('fetching git version...'), findsOneWidget);
  });

  testWidgets('it displays git version when fully loaded',
      (WidgetTester tester) async {
    final GitProxy git = GitProxyMock();
    final GitDependentLoader loader = GitDependentLoader();
    loader.gitProxy = git;

    await tester.pumpWidget(loader.loadAppWithWidget(const GitChip()));
    await tester.pumpAndSettle();

    expect(find.text(await git.gitVersion()), findsOneWidget);
  });
}
