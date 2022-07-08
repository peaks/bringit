import 'package:git_ihm/git/base_command/terminal_command.dart';

class VersionFetcher {
  Future<String> fetch() async {
    final TerminalCommand command =
        TerminalCommand('git', <String>['--version']);

    return command.run();
  }
}
