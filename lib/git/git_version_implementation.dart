import 'package:git_ihm/data/git/git_version_command.dart';
import 'package:git_ihm/git/base_command/version_fetcher.dart';

class GitVersionImplementation extends GitVersionCommand {
  GitVersionImplementation(this.fetcher);

  final VersionFetcher fetcher;
  final RegExp _versionRegex = RegExp(r'[1-9](\.[0-9]{0,2}){0,2}');

  @override
  Future<String> run() async {
    final RegExpMatch? versionMatch = _versionRegex.firstMatch(
        await fetcher.fetch());

    return versionMatch == null ? '' : versionMatch.group(0)!;
  }
}