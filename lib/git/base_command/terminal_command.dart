import 'dart:io';

class TerminalCommand {
  TerminalCommand(this.command, [List<String> parameters = const <String>[]]) {
    _parameters = parameters;
  }

  final String command;
  late final List<String> _parameters;

  Future<String> run([String? workingDirectory]) async {
    final ProcessResult result = await Process.run(command, _parameters,
        workingDirectory: workingDirectory);

    if (_commandIsSuccessful(result)) {
      return (result.stdout as String).trim();
    }

    return '';
  }

  bool _commandIsSuccessful(ProcessResult result) =>
      result.stdout is String && result.exitCode == 0;
}
