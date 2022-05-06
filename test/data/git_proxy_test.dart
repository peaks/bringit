import 'package:git_ihm/data/git/status_file.dart';
import 'package:git_ihm/data/git_proxy.dart';
import 'package:test/test.dart';

import '../mock/git_registry_mock.dart';
import '../mock/path_manager_mock.dart';

void main() {
  late GitRegistryMock registry;
  late PathManagerMock pathManager;
  late GitProxy testSubject;

  setUp(() {
    registry = GitRegistryMock();
    pathManager = PathManagerMock('');
    testSubject = GitProxyImplementation(registry, pathManager);
  });

  test('it delegates git --version to GitVersionCommand', () async {
    const String mockedGitVersion = '1.0';
    registry.versionCommandMock.willReturn(mockedGitVersion);
    expect(await testSubject.gitVersion(), same(mockedGitVersion));
  });

  test('it delegates gitStatus to GitStatusCommand', () async {
    const String gitPath = '/foo/bar';
    const List<StatusFile> commandResult = <StatusFile>[
      UntrackedPath('any/path')
    ];

    registry.statusCommandMock.withParameter(gitPath).willReturn(commandResult);

    expect(await testSubject.gitStatus(gitPath), same(commandResult));
  });

  test('it fetches path from pathManager', () {
    expect(testSubject.path, same(pathManager.path));
  });

  test('it updates path in pathManager', () {
    const String newPath = '/new/path';
    testSubject.path = newPath;
    expect(pathManager.path, equals(newPath));
  });

  test('git directories are detected', () async {
    const String goodPath = '/tmp/git-ihm/gitProject';
    const String badPath = '/tmp/git-ihm/nonGitProject';
    expect(await testSubject.isGitDir(goodPath), true);
    expect(await testSubject.isGitDir(badPath), false);
  }, tags: <String>['git-interpreter']);
}
