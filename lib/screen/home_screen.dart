import 'dart:io';

import 'package:flutter/material.dart';
import 'package:git_ihm/utils/command_level_enum.dart';
import 'package:git_ihm/widget/button/command_button.dart';
import 'package:git_ihm/widget/clever_infos.dart';
import 'package:git_ihm/widget/commit_graph.dart';
import 'package:git_ihm/widget/console/command_result.dart';
import 'package:git_ihm/widget/console/git_console.dart';
import 'package:git_ihm/widget/file_tree.dart';
import 'package:git_ihm/widget/git_chip.dart';
import 'package:git_ihm/widget/panel_container.dart';
import 'package:git_ihm/widget/path_selector.dart';
import 'package:git_ihm/widget/project_path.dart';
import 'package:git_ihm/widget/repository_status.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _cmdController = TextEditingController();
  final FocusNode _cmdFocus = FocusNode();
  bool _lastCommandSucceeded = true;

  CommandResult _runCommand(String command) {
    _setCurrentCommand(command);
    final ProcessResult result = Process.runSync('git', command.split(' '), includeParentEnvironment: false, workingDirectory: './');
    setState(() {
      _lastCommandSucceeded = result.exitCode == 0;
    });
    _cmdFocus.requestFocus();
    return CommandResult(stdout: result.stdout.toString(), stderr: result.stderr.toString(), success: result.exitCode == 0);
  }

  void _setCurrentCommand(String command) {
    _cmdController.text = command;
    _cmdFocus.requestFocus();
    _cmdController.selection = TextSelection.fromPosition(TextPosition(offset: _cmdController.text.length));
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

  @override
  Widget build(BuildContext context) {
    final List<CommandButton> commands = <CommandButton>[];
    commands.addAll(infoCommands.map((String command) => CommandButton(
          title: command,
          onPressed: () => _runCommand(command),
          level: CommandLevel.info,
        )));
    commands.addAll(remoteCommands.map((String command) => CommandButton(title: command, onPressed: () => _runCommand(command), level: CommandLevel.remote)));
    commands.addAll(safeCommands.map((String command) => CommandButton(title: command, onPressed: () => _runCommand(command), level: CommandLevel.safe)));
    commands.addAll(dangerousCommands.map((String command) => CommandButton(title: command, onPressed: () => _runCommand(command), level: CommandLevel.dangerous)));

    return Scaffold(
        appBar: _appBar(),
        body: Container(
            padding: const EdgeInsets.all(8.0),
            child: Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
              Flexible(
                  flex: 1,
                  child: Row(
                    children: <Widget>[
                      GitConsole(),
                      _info(),
                    ],
                  )),
              Flexible(
                  flex: 3,
                  child: Row(
                    children: <Widget>[_fileTree(), _commitTree(), _repositoryStatus()],
                  ))
            ])),
        bottomNavigationBar: _footer());
  }

  AppBar _appBar() => AppBar(
        title: Text(widget.title),
        actions: const <Widget>[PathSelector()],
      );

  Expanded _info() => _buildExpandedPanelContainer('Smart', const CleverInfos());

  Expanded _buildExpandedPanelContainer(String title, Widget child) {
    return Expanded(
      flex: 1,
      child: PanelContainer(
        title: title,
        child: child,
      ),
    );
  }

  Expanded _commitTree() => _buildExpandedPanelContainer('Commits', const CommitTree());

  Expanded _fileTree() => _buildExpandedPanelContainer('Files', const FileTree());

  Expanded _repositoryStatus() => _buildExpandedPanelContainer('Status', const Expanded(child: RepositoryStatus()));

  BottomAppBar _footer() => BottomAppBar(
          child: Row(
        children: const <Widget>[GitChip(), Expanded(child: ProjectPath())],
      ));
}
