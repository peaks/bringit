import 'package:git_ihm/git/parsers/status_parser.dart';

import '../data/git/git_status_command.dart';
import '../data/git/status_file.dart';
import 'base_command/status_command.dart';

class GitStatusImplementation extends GitStatusCommand {
  GitStatusImplementation(this._parser, this._baseCommand);

  final StatusParser _parser;
  final StatusCommand _baseCommand;

  @override
  Future<List<StatusFile>> run(String path) async {
    return _map(await _baseCommand.run(path));
  }

  List<StatusFile> _map(List<String> gitStatus)
  {
    final List<StatusFile> results = <StatusFile>[];

    for (final String element in gitStatus) {
      results.add(_parser.parse(element));
    }

    return results;
  }
}
