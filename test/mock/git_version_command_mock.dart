import 'package:git_ihm/data/git/git_version_command.dart';

class GitVersionCommandMock extends GitVersionCommand {
  String runResult = '1.2';

  @override
  Future<String> run() async {
    return runResult;
  }
}
