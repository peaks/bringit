import 'package:git_ihm/data/git_proxy.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../git/git_registry.dart';
import '../git_proxy_implementation.dart';
import '../path_manager.dart';

class GitFactory {
  Future<GitProxy> getGit() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final GitRegistry registry = GitRegistry();
    return GitProxyImplementation(registry, SpPathManager(sp));
  }
}
