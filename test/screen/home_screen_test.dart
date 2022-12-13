@Tags(<String>['file-system-dependent'])

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:git_ihm/screen/home_screen.dart';
import 'package:git_ihm/widget/git_chip.dart';
import 'package:git_ihm/widget/path_selector.dart';

import '../git_dependent_loader.dart';
import '../mock/git_proxy_mock.dart';

void main() {
  testWidgets('contains AppBar with title', (WidgetTester tester) async {
    const String expectedTitle = 'any title';
    await buildHomeScreen(tester, expectedTitle);

    expect(find.widgetWithText(AppBar, expectedTitle), findsOneWidget);
  });

  testWidgets('AppBar contains a PathSelector widget',
      (WidgetTester tester) async {
    await buildHomeScreen(tester);

    expect(findPathSelectorInAppBar(), findsOneWidget);
  });

  testWidgets('AppBar contains a GitChip widget', (WidgetTester tester) async {
    await buildHomeScreen(tester);

    expect(findGitChip(), findsOneWidget);
  });
}

Future<void> buildHomeScreen(WidgetTester tester, [String title = '']) async {
  final GitProxyMock gitProxy = GitProxyMock();
  gitProxy.path = '/tmp/git-ihm/nonGitProject';

  final GitDependentLoader loader = GitDependentLoader();
  loader.gitProxy = gitProxy;

  await tester.pumpWidget(loader.loadAppWithWidget(HomeScreen(title: title)));
}

Widget createWidgetForTesting(Widget child) {
  return MaterialApp(
    home: child,
  );
}

Finder findPathSelectorInAppBar() {
  return find.descendant(
      of: find.byType(AppBar), matching: find.byType(PathSelector));
}

Finder findGitChip() {
  return find.byType(GitChip);
}
