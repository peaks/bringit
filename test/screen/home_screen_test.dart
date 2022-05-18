import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:git_ihm/screen/home_screen.dart';
import 'package:git_ihm/screen/shared/path_selector.dart';

import '../git_dependent_loader.dart';

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
}

Future<void> buildHomeScreen(WidgetTester tester, [String title = '']) async {
  final GitDependentLoader loader = GitDependentLoader();
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
