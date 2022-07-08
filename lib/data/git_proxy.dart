import 'package:flutter/cupertino.dart';
import 'package:git_ihm/data/git/git_commit.dart';
import 'package:git_ihm/data/git/status_file.dart';

abstract class GitProxy extends ChangeNotifier {
  Future<bool> isGitDir(String path);

  Future<List<StatusFile>> gitStatus(String path);

  Future<String> gitVersion();

  String get path;

  set path(String newPath);

  List<StatusFile> gitState = <StatusFile>[];

  Future<void> getStatus();

  Future<List<GitCommit>> gitLog();
}
