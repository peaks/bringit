import 'dart:io';

class VersionFetcher {
  Future<String> fetch() async {
    final ProcessResult result = await Process.run('git',
        <String>['--version']);
    return getStdoutOrEmptyStringOnFailure(result);
  }

  String getStdoutOrEmptyStringOnFailure(ProcessResult result) {
    final dynamic stdout = result.stdout;
    if (stdout is String && result.exitCode == 0) {
      return stdout.trim();
    }
    return '';
  }
}