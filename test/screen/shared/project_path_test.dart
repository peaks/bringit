import 'package:flutter_test/flutter_test.dart';
import 'package:git_ihm/screen/shared/project_path.dart';

import '../../git_dependent_loader.dart';
import '../../mock/git_proxy_mock.dart';

void main() {
  testWidgets('it displays notifier path value', (WidgetTester tester) async {
    final GitProxyMock pathManager =
        await getPathManagerFromApplication(tester);

    expect(find.text(pathManager.path), findsOneWidget);
  });

  testWidgets('it updates path when notified', (WidgetTester tester) async {
    final GitProxyMock pathManager =
        await getPathManagerFromApplication(tester);
    pathManager.path = '/new/path';
    await tester.pumpAndSettle();

    expect(find.text(pathManager.path), findsOneWidget);
  });
}

Future<GitProxyMock> getPathManagerFromApplication(WidgetTester tester) async {
  final GitProxyMock pathManager = GitProxyMock();
  final GitDependentLoader loader = GitDependentLoader();
  loader.gitProxy = pathManager;
  await tester.pumpWidget(loader.loadAppWithWidget(const ProjectPath()));

  return pathManager;
}
