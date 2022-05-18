import 'dart:convert';
import 'dart:io';

import 'package:git_ihm/git/base_command/base_command.dart';

class StatusFetcher extends BaseCommand {
  static const LineSplitter _splitter = LineSplitter();

  Future<List<String>> fetch(String path) async {
    final String results = await _callGitStatus(path);
    return _splitter.convert(results);
  }

  Future<String> _callGitStatus(String path) async {
    final ProcessResult result = await Process.run(
        'git', <String>['status', '--porcelain=v1', '--ignored=matching'],
        workingDirectory: path);

    if (commandIsSuccessful(result)) {
      return result.stdout as String;
    }

    return '';
  }
}
