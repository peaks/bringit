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

import 'package:flutter/material.dart';
import 'package:git_ihm/helpers/wording.dart';
import 'package:git_ihm/presentation/widget/console/git_console_command_result.dart';
import 'package:git_ihm/presentation/widget/console/git_console_history.dart';
import 'package:git_ihm/presentation/widget/console/git_console_input.dart';
import 'package:git_ihm/presentation/widget/shared/scrollable_panel_container.dart';

class GitConsole extends StatefulWidget {
  const GitConsole({
    Key? key,
  }) : super(key: key);

  @override
  State<GitConsole> createState() => _GitConsoleState();
}

class _GitConsoleState extends State<GitConsole> {
  final Map<GlobalKey<GitConsoleHistoryState>, GitConsoleHistory>
      _gitConsoleHistory =
      <GlobalKey<GitConsoleHistoryState>, GitConsoleHistory>{};

  final TextEditingController cmdController = TextEditingController();

  final FocusNode cmdFocus = FocusNode();

  bool lastCommandSucceeded = true;

  final ScrollController _scrollController = ScrollController();

  // TODO(thibault):  check used methods
  void _setCurrentCommand(String command) {
    cmdController.text = command;
    cmdFocus.requestFocus();
    cmdController.selection = TextSelection.fromPosition(
        TextPosition(offset: cmdController.text.length));
  }

  final List<String> infoCommands = <String>[
    'status',
    'branch',
    'log',
    'remote',
    'diff',
    // 'config',
    'show',
  ];

  final List<String> remoteCommands = <String>[
    'push',
    // 'clone',
    'fetch',
    'pull',
  ];

  final List<String> safeCommands = <String>[
    'commit',
    // 'add',
    // 'checkout',
    'rebase',
    'stash',
    // 'restore',
    'config',
    'init',
    // 'mv',
  ];

  final List<String> dangerousCommands = <String>[
    // 'reset',
    // 'rm',
    'clean',
  ];

  GitConsoleCommandResult _runCommand(String command) {
    _setCurrentCommand(command);
    final ProcessResult result = Process.runSync('git', command.split(' '),
        includeParentEnvironment: false, workingDirectory: './');
    setState(() {
      lastCommandSucceeded = result.exitCode == 0;
    });
    cmdFocus.requestFocus();
    return GitConsoleCommandResult(
        stdout: result.stdout.toString(),
        stderr: result.stderr.toString(),
        success: result.exitCode == 0);
  }

  void runCommand(String command) {
    final GitConsoleCommandResult result = _runCommand(command);

    // Collapse last command result
    if (_gitConsoleHistory.isNotEmpty) {
      _gitConsoleHistory.keys.last.currentState?.expanded(false);
    }

    final GlobalKey<GitConsoleHistoryState> historyKey =
        GlobalKey<GitConsoleHistoryState>();
    _gitConsoleHistory.putIfAbsent(
        historyKey,
        () => GitConsoleHistory(
              key: historyKey,
              command: 'git $command',
              stdout: result.stdout,
              stderr: result.stderr,
              success: result.success,
            ));
    _scrollController.animateTo(_scrollController.position.minScrollExtent,
        curve: Curves.bounceIn, duration: const Duration(microseconds: 10));
    cmdController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return ScrollablePanelContainer(
      title: Wording.consoleBlockTitle,
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: ListView(
            shrinkWrap: true,
            reverse: true,
            children: _gitConsoleHistory.values.toList(),
          )),
      footer: GitConsoleInput(
          cmdController: cmdController,
          cmdFocus: cmdFocus,
          lastCommandSucceeded: lastCommandSucceeded,
          runCommand: runCommand),
    );
  }
}
