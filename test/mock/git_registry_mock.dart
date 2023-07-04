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
