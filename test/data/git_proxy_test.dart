import 'package:git_ihm/data/git/git_status_command.dart';
import 'package:git_ihm/data/git/status_file.dart';
import 'package:git_ihm/data/git_proxy.dart';
import 'package:test/test.dart';

void main() {
  late GitStatusCommandMock gitStatusCommandMock;
  late GitProxy testSubject;

  setUp(() {
    gitStatusCommandMock = GitStatusCommandMock();
    testSubject = GitProxyImplementation(gitStatusCommandMock);
  });

  test('it delegates gitStatus to GitStatusCommand', () async {
    const String gitPath = '/foo/bar';
    const List<StatusFile> commandResult = <StatusFile>[
      UntrackedPath('any/path')
    ];

    gitStatusCommandMock.withParameter(gitPath).willReturn(commandResult);

    expect(await testSubject.gitStatus(gitPath), same(commandResult));
  });

  test('git directories are detected', () async {
    const String goodPath = '/tmp/git-ihm/gitProject';
    const String badPath = '/tmp/git-ihm/nonGitProject';
    expect(await testSubject.isGitDir(goodPath), true);
    expect(await testSubject.isGitDir(badPath), false);
  }, tags: <String>['git-interpreter']);
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
