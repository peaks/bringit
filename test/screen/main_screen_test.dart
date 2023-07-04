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
@Tags(<String>['file-system-dependent'])

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:git_ihm/screen/main_screen.dart';
import 'package:git_ihm/widget/side_menu.dart' as side_menu_custom;
import 'package:git_ihm/widget/status_bar.dart';

import '../git_dependent_loader.dart';
import '../mock/git_proxy_mock.dart';

void main() {
  testWidgets('contains a ProjectTabBar widget', (WidgetTester tester) async {
    await buildMainScreen(tester);

    expect(findTabBar(), findsOneWidget);
  });
  testWidgets('contains TabBar with project name', (WidgetTester tester) async {
    const String expectedTitle = 'Project 1';
    await buildMainScreen(tester);

    expect(find.widgetWithText(AppBar, expectedTitle), findsOneWidget);
  });
  testWidgets('contains a SideMenu widget', (WidgetTester tester) async {
    await buildMainScreen(tester);

    expect(findSideMenu(), findsOneWidget);
  });

  testWidgets('contains a StatusBar widget', (WidgetTester tester) async {
    await buildMainScreen(tester);

    expect(findStatusBarInApp(), findsOneWidget);
  });
}

Future<void> buildMainScreen(WidgetTester tester) async {
  final GitProxyMock gitProxy = GitProxyMock();
  gitProxy.path = '/tmp/git-ihm/nonGitProject';

  final GitDependentLoader loader = GitDependentLoader();
  loader.gitProxy = gitProxy;

  await tester.pumpWidget(loader.loadAppWithWidget(const MainScreen()));
}

Widget createWidgetForTesting(Widget child) {
  return MaterialApp(
    home: child,
  );
}

Finder findStatusBarInApp() {
  return find.byType(StatusBar);
}

Finder findTabBar() {
  return find.byType(AppBar);
}

Finder findSideMenu() {
  return find.byType(side_menu_custom.SideMenu);
}
