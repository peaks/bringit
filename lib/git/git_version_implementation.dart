/*
 * Copyright (c) 2020 Peaks
 *
 * This file is part of GitGud
 *
 * GitGud is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * GitGud is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with GitGud.  If not, see <http://www.gnu.org/licenses/>.
 */
import 'package:git_ihm/data/git/git_version_command.dart';
import 'package:git_ihm/git/base_command/version_fetcher.dart';

class GitVersionImplementation extends GitVersionCommand {
  GitVersionImplementation(this.fetcher);

  final VersionFetcher fetcher;
  final RegExp _versionRegex = RegExp(r'[1-9](\.[0-9]{0,2}){0,2}');

  @override
  Future<String> run() async {
    final RegExpMatch? versionMatch =
        _versionRegex.firstMatch(await fetcher.fetch());

    return versionMatch == null ? '' : versionMatch.group(0)!;
  }
}
