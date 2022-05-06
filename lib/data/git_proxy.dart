import 'package:git_ihm/data/git/status_file.dart';

abstract class GitProxy {
  Future<bool> isGitDir(String path);

  Future<List<StatusFile>> gitStatus(String path);

  Future<String> gitVersion();

  String get path;

  set path(String newPath);
}
