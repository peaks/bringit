import 'package:git_ihm/data/git/git_version_command.dart';

class GitVersionCommandMock extends GitVersionCommand {
  String runResult = '';

  void willReturn(String expectedReturn) {
    runResult = expectedReturn;
  }

  @override
  Future<String> run() async {
    return runResult;
  }
}
