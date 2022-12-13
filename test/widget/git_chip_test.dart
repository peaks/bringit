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
