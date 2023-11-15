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

import 'dart:io';

import 'package:git_ihm/domain/git/base_command/shell_command.dart';

/// This class aims to separate the raw return of a command and the higher level
/// of return desired, while preserving error messages if needed

class CommandResult<T> {
  CommandResult(this.result, ProcessResult processResult) {
    _processResult = processResult;
  }
  final T result;
  late final ProcessResult _processResult;
  bool get isSuccessful => _processResult.isSuccessful;
  int get exitCode => _processResult.exitCode;
  dynamic get stderr => _processResult.stderr;
  dynamic get stdout => _processResult.stdout;
}
