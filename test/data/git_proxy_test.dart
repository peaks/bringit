import 'package:git_ihm/data/git/git_status_command.dart';
import 'package:git_ihm/data/git/status_file.dart';
import 'package:git_ihm/data/git_proxy.dart';
import 'package:git_ihm/git/git_registry.dart';
import 'package:test/test.dart';

void main() {
  test('it delegates gitStatus to GitStatusCommand', () async {
    final GitRegistryMock mockedRegistry = GitRegistryMock();
    final GitStatusCommandMock gitStatusCommandMock =
        mockedRegistry.gitStatusCommand;
    final GitProxy testSubject = GitProxyImplementation(gitStatusCommandMock);

    const String gitPath = '/foo/bar';
    const List<StatusFile> commandResult = <StatusFile>[
      UntrackedPath('any/path')
    ];

    gitStatusCommandMock.withParameter(gitPath).willReturn(commandResult);

    expect(await testSubject.gitStatus(gitPath), same(commandResult));
  });
}

class GitStatusCommandMock extends GitStatusCommand {
  List<StatusFile> mockedResult = <StatusFile>[];
  String expectedParameter = '';

  @override
  Future<List<StatusFile>> run(String path) async {
    if (path != expectedParameter) {
      throw Exception(
          'Failed asserting method "run" parameter: expecting "$expectedParameter", actual: "$path"');
    }
    return mockedResult;
  }

  void willReturn(List<StatusFile> list) {
    mockedResult = list;
  }

  GitStatusCommandMock withParameter(String gitPath) {
    expectedParameter = gitPath;

    return this;
  }
}

class GitRegistryMock extends GitRegistry {
  final GitStatusCommandMock _gitStatusMock = GitStatusCommandMock();

  @override
  GitStatusCommandMock get gitStatusCommand => _gitStatusMock;
}
