import 'dart:io';

import 'package:flutter/material.dart';
import 'package:git_ihm/helpers/wording.dart';
import 'package:git_ihm/widget/console/command_result.dart';
import 'package:git_ihm/widget/console/git_console_history.dart';
import 'package:git_ihm/widget/console/git_console_input.dart';
import 'package:git_ihm/widget/scrollable_panel_container.dart';

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

  CommandResult _runCommand(String command) {
    _setCurrentCommand(command);
    final ProcessResult result = Process.runSync('git', command.split(' '),
        includeParentEnvironment: false, workingDirectory: './');
    setState(() {
      lastCommandSucceeded = result.exitCode == 0;
    });
    cmdFocus.requestFocus();
    return CommandResult(
        stdout: result.stdout.toString(),
        stderr: result.stderr.toString(),
        success: result.exitCode == 0);
  }

  void runCommand(String command) {
    final CommandResult result = _runCommand(command);

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
