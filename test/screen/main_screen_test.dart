import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:git_ihm/screen/main_screen.dart';
import 'package:git_ihm/screen/status_bar.dart';

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
  await tester.pumpWidget(const MainScreen());
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
