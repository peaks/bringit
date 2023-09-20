/* import 'package:git_ihm/data/git/git_init_command.dart';
import 'package:git_ihm/git/base_command/init_fetcher.dart';

class GitInitImplementation extends GitInitCommand {
  GitInitImplementation(this.fetcher);

  final InitFetcher fetcher;

  @override
  Future<String> run(String path) async {
    final String initStatus = await fetcher.fetch(path);

    // Check if the Git repository is initialized
    final bool isInitialized = initStatus.isNotEmpty;

    return isInitialized ? 'Initialized' : 'Not initialized';
  }
} */
