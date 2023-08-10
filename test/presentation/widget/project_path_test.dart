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
import 'package:git_ihm/presentation/widget/status_bar/project_path.dart';

import '../../services/mock/git_proxy_mock.dart';
import '../../utils/git_dependent_loader.dart';

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
