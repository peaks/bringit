import 'package:flutter/material.dart';
import 'package:git_ihm/widget/console/command_result.dart';
import 'package:git_ihm/widget/console/git_console_history.dart';
import 'package:git_ihm/widget/console/git_console_input.dart';

class GitConsole extends StatefulWidget {
  const GitConsole({
    required this.cmdController,
    required this.cmdFocus,
    required this.resultController,
    required this.lastCommandSucceeded,
    required this.runCommand,
  });

  final TextEditingController cmdController;
  final FocusNode cmdFocus;
  final TextEditingController resultController;
  final bool lastCommandSucceeded;
  final CommandResult Function(String) runCommand;

  @override
  State<GitConsole> createState() => _GitConsoleState();
}

class _GitConsoleState extends State<GitConsole> {
  final Map<GlobalKey<GitConsoleHistoryState>, GitConsoleHistory>
      _gitConsoleHistory =
      <GlobalKey<GitConsoleHistoryState>, GitConsoleHistory>{};

  final ScrollController _scrollController = ScrollController();

  void runCommand(String command) {
    final CommandResult result = widget.runCommand(command);

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
    widget.cmdController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GitConsoleInput(
            cmdController: widget.cmdController,
            cmdFocus: widget.cmdFocus,
            lastCommandSucceeded: widget.lastCommandSucceeded,
            runCommand: runCommand),
        Expanded(
            child: Scrollbar(
                controller: _scrollController,
                thumbVisibility: true,
                child: SingleChildScrollView(
                    controller: _scrollController,
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: ListView(
                          shrinkWrap: true,
                          reverse: true,
                          children: _gitConsoleHistory.values.toList(),
                        ))))),
      ],
    );
  }
}
