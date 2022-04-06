import 'package:git_ihm/data/git/status_file.dart';

abstract class GitStatusCommand {
  Future<List<StatusFile>> run(String path);
}
