import 'package:git_ihm/data/git/git_status_command.dart';
import 'package:git_ihm/data/git/status_file.dart';

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
