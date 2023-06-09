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
import 'package:git_ihm/data/git/git_status_command.dart';
import 'package:git_ihm/data/git/git_version_command.dart';
import 'package:git_ihm/git/base_command/log_fetcher.dart';
import 'package:git_ihm/git/base_command/status_fetcher.dart';
import 'package:git_ihm/git/base_command/version_fetcher.dart';
import 'package:git_ihm/git/git_log_implementation.dart';
import 'package:git_ihm/git/git_status_implementation.dart';
import 'package:git_ihm/git/git_version_implementation.dart';
import 'package:git_ihm/git/parsers/commit_parser.dart';
import 'package:git_ihm/git/parsers/status_parser.dart';

import '../data/git/git_log_command.dart';

class GitRegistry {
  GitStatusCommand get statusCommand =>
      GitStatusImplementation(StatusParser(), StatusFetcher());

  GitVersionCommand get versionCommand =>
      GitVersionImplementation(VersionFetcher());

  GitLogCommand get logCommand =>
      GitLogImplementation(LogFetcher(), CommitParser());
}
