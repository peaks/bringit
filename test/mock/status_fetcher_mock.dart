import 'package:git_ihm/git/base_command/status_fetcher.dart';

class StatusFetcherMock extends StatusFetcher {
  List<String> runResult = <String>[];
  String expectedPath = '';

  @override
  Future<List<String>> fetch(String path) async {
    if (expectedPath.isEmpty) {
      throw Exception('expectedPath for mocked method run is not initialized');
    }
    if (expectedPath != path) {
      throw Exception('Failed to assert method "run" parameter, expected: "$expectedPath", actual: "$path"');
    }
    return runResult;
  }

  void pushUntrackedResult(String filePath) {
    runResult.add('?? $filePath');
  }

  void pushModifiedResult(String filePath) {
    runResult.add(' M $filePath');
  }

  void pushModifiedOrAddedResult(String filePath) {
    runResult.add('M  $filePath');
  }

  void pushUntrackedAndAdded(String filePath) {
    runResult.add('A  $filePath');
  }

  void willRunFor(String gitDirectory) {
    expectedPath = gitDirectory;
  }
}