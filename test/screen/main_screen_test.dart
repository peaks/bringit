@Tags(<String>['file-system-dependent'])

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:git_ihm/screen/main_screen.dart';
import 'package:git_ihm/screen/side_menu.dart';
import 'package:git_ihm/screen/status_bar.dart';

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
  return find.byType(SideMenu);
}
