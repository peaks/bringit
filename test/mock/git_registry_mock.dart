import 'package:git_ihm/data/git/git_status_command.dart';
import 'package:git_ihm/data/git/git_version_command.dart';
import 'package:git_ihm/git/git_registry.dart';

import 'git_status_command_mock.dart';
import 'git_version_command_mock.dart';

class GitRegistryMock extends GitRegistry {
  GitRegistryMock() {
    statusCommandMock = GitStatusCommandMock();
    versionCommandMock = GitVersionCommandMock();
  }

  late GitStatusCommand statusCommandMock;
  late GitVersionCommandMock versionCommandMock;

  @override
  GitStatusCommand get statusCommand => statusCommandMock;

  @override
  GitVersionCommand get versionCommand => versionCommandMock;
}
