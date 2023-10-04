// void main() {
//   TestWidgetsFlutterBinding.ensureInitialized();
//   IntegrationTestWidgetsFlutterBinding.ensureInitialized();
//   testWidgets('it updates project path on updates',
//       (WidgetTester tester) async {
//     await runTestApplication(tester);

//     const String newPath = '/tmp/git-ihm/gitProject';
//     await updateProjectPath(tester, newPath);

//     expect(find.textContaining('project: $newPath'), findsOneWidget);
//   });
// }

// Future<void> runTestApplication(WidgetTester tester) async {
//   final GitProxy git = buildGitProxyWithMocks();
//   await loadApplication(tester, git);
// }

// GitProxyImplementation buildGitProxyWithMocks() {
//   return GitProxyImplementation(
//       GitRegistryMock(), PathManagerMock('/original/path'));
// }

// Future<void> loadApplication(WidgetTester tester, GitProxy git) async {
//   const MainScreen mainScreen = MainScreen();
//   final GitDependentLoader loader = GitDependentLoader();
//   loader.gitProxy = git;
//   await tester.pumpWidget(loader.loadAppWithWidget(mainScreen));
// }

// Future<void> updateProjectPath(WidgetTester tester, String newPath) async {
//   await tester.tap(find.byType(PathSelector));
//   await tester.pumpAndSettle();
//   await tester.enterText(findModalTextField(), newPath);
//   await tester.pumpAndSettle();
//   await tester.tap(find.widgetWithText(TextButton, 'Save'));
//   await tester.pumpAndSettle();
// }
