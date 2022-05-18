import 'dart:io';

import 'base_command.dart';

class VersionFetcher extends BaseCommand {
  Future<String> fetch() async {
    final ProcessResult result =
        await Process.run('git', <String>['--version']);

    if (commandIsSuccessful(result)) {
      return (result.stdout as String).trim();
    }
    return '';
  }
}
