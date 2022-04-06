import 'package:git_ihm/data/git/git_status_command.dart';
import 'package:git_ihm/git/base_command/status_command.dart';
import 'package:git_ihm/git/git_status_implementation.dart';
import 'package:git_ihm/git/parsers/status_parser.dart';

class GitRegistry {
  GitStatusCommand get gitStatusCommand => GitStatusImplementation(
      StatusParser(), StatusCommand()
  );
}