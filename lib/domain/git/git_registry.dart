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

import 'package:git_ihm/domain/git/add/git_add_command.dart';
import 'package:git_ihm/domain/git/add/git_add_implementation.dart';
import 'package:git_ihm/domain/git/add_all/git_add_all_command.dart';
import 'package:git_ihm/domain/git/add_all/git_add_all_implementation.dart';
import 'package:git_ihm/domain/git/commit/commit_parser.dart';
import 'package:git_ihm/domain/git/init/git_init_command.dart';
import 'package:git_ihm/domain/git/init/git_init_implementation.dart';
import 'package:git_ihm/domain/git/log/git_log_command.dart';
import 'package:git_ihm/domain/git/log/git_log_implementation.dart';
import 'package:git_ihm/domain/git/log/log_parser.dart';
import 'package:git_ihm/domain/git/restore_staged/git_restore_staged_command.dart';
import 'package:git_ihm/domain/git/restore_staged/git_restore_staged_implementation.dart';
import 'package:git_ihm/domain/git/restore_staged_all/git_restore_staged_command.dart';
import 'package:git_ihm/domain/git/restore_staged_all/git_restore_staged_implementation.dart';
import 'package:git_ihm/domain/git/status/git_status_command.dart';
import 'package:git_ihm/domain/git/status/git_status_implementation.dart';
import 'package:git_ihm/domain/git/status/status_parser.dart';
import 'package:git_ihm/domain/git/version/git_version_command.dart';
import 'package:git_ihm/domain/git/version/git_version_implementation.dart';

class GitRegistry {
  GitStatusCommand get statusCommand => GitStatusImplementation(
        StatusParser(),
      );

  GitVersionCommand get versionCommand => GitVersionImplementation();

  GitLogCommand get logCommand =>
      GitLogImplementation(LogParser(CommitParser()));

  GitInitCommand get initCommand => GitInitImplementation();

  GitAddAllCommand get addAllCommand => GitAddAllImplementation();
  GitAddCommand get addCommand => GitAddImplementation();

  GitRestoreStagedAllCommand get restoreStagedAllCommand =>
      GitRestoreStagedAllImplementation();

  GitRestoreStagedCommand get restoreStagedCommand =>
      GitRestoreStagedImplementation();
}
