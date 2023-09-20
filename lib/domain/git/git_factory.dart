/*
 * Copyright (c) 2020 Peaks
 *
 * This file is part of Brin'Git
 *
 * Brin'Git is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * Brin'Git is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with Brin'Git.  If not, see <http://www.gnu.org/licenses/>.
 */

import 'package:git_ihm/domain/git/git_proxy.dart';
import 'package:git_ihm/domain/git/git_proxy_implementation.dart';
import 'package:git_ihm/domain/path/path_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'git_registry.dart';

class GitFactory {
  Future<GitProxy> getGit() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final GitRegistry registry = GitRegistry();
    return GitProxyImplementation(registry, SpPathManager(sp));
  }
}
