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
import 'dart:io';

class TerminalCommand {
  TerminalCommand(this.command, [List<String> parameters = const <String>[]]) {
    _parameters = parameters;
  }

  final String command;
  late final List<String> _parameters;

  Future<String> run([String? workingDirectory]) async {
    final ProcessResult result = await Process.run(command, _parameters,
        workingDirectory: workingDirectory);

    if (_commandIsSuccessful(result)) {
      return (result.stdout as String).trim();
    }

    return '';
  }

  bool _commandIsSuccessful(ProcessResult result) =>
      result.stdout is String && result.exitCode == 0;
}
