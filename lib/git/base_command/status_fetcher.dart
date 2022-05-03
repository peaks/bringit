import 'dart:convert';
import 'dart:io';

import 'package:git/git.dart';
import 'package:git_ihm/git/base_command/base_command.dart';

class StatusFetcher extends BaseCommand {
  static const LineSplitter _splitter = LineSplitter();

  Future<List<String>> fetch(String path) async {
    final GitDir git = await GitDir.fromExisting(path);
    final String results = await _callGitStatus(git);
    return _splitter.convert(results);
  }

  Future<String> _callGitStatus(GitDir git) async {
    final ProcessResult result = await git
        .runCommand(<String>['status', '--porcelain=v1', '--ignored=matching']);

    if (commandIsSuccessful(result)) {
      return result.stdout as String;
    }

    return '';
  }
}
