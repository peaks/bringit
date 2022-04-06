import 'dart:io';

import 'package:flutter/material.dart';
import 'package:git_ihm/data/git_proxy.dart';
import 'package:git_ihm/data/path_manager.dart';
import 'package:git_ihm/git/git_registry.dart';
import 'package:git_ihm/utils/command_level_enum.dart';
import 'package:git_ihm/widgets/button/command_button.dart';
import 'package:git_ihm/widgets/clever_infos.dart';
import 'package:git_ihm/widgets/commit_graph.dart';
import 'package:git_ihm/widgets/console/command_result.dart';
import 'package:git_ihm/widgets/console/git_console.dart';
import 'package:git_ihm/widgets/file_tree.dart';
import 'package:git_ihm/widgets/panel_container.dart';
import 'package:git_ihm/widgets/repository_status.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'shared/path_selector.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen(
      {Key? key, required this.title, required this.sharedPreferences})
      : super(key: key);

  final String title;
  final SharedPreferences sharedPreferences;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _cmdController = TextEditingController();
  final FocusNode _cmdFocus = FocusNode();
  final TextEditingController _resultController = TextEditingController();
  bool _lastCommandSucceeded = true;

  CommandResult _runCommand(String command) {
    _setCurrentCommand(command);
    final ProcessResult result = Process.runSync('git', command.split(' '),
        includeParentEnvironment: false, workingDirectory: './');
    setState(() {
      _lastCommandSucceeded = result.exitCode == 0;
    });
    _cmdFocus.requestFocus();
    return CommandResult(
        stdout: result.stdout.toString(),
        stderr: result.stderr.toString(),
        success: result.exitCode == 0);
  }

  void _setCurrentCommand(String command) {
    _cmdController.text = command;
    _cmdFocus.requestFocus();
    _cmdController.selection = TextSelection.fromPosition(
        TextPosition(offset: _cmdController.text.length));
  }

  String _getGitVersion() {
    // TODO(all): get version from the git lib once selected
    return Process.runSync('git', <String>['--version'],
            includeParentEnvironment: false, workingDirectory: './')
        .stdout
        .toString()
        .split(' ')
        .last;
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
    commands.addAll(remoteCommands.map((String command) => CommandButton(
        title: command,
        onPressed: () => _runCommand(command),
        level: CommandLevel.remote)));
    commands.addAll(safeCommands.map((String command) => CommandButton(
        title: command,
        onPressed: () => _runCommand(command),
        level: CommandLevel.safe)));
    commands.addAll(dangerousCommands.map((String command) => CommandButton(
        title: command,
        onPressed: () => _runCommand(command),
        level: CommandLevel.dangerous)));

    // TODO(lreus): fix GitProxy injection either with inherited widget or factory.
    final GitRegistry registry = GitRegistry();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          PathSelector(SpPathManager(widget.sharedPreferences),
              GitProxyImplementation(registry.gitStatusCommand))
        ],
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(8),
        child: Chip(
          avatar: const Icon(MdiIcons.git, size: 20),
          label: Text(
            _getGitVersion(),
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
            //Wrap(alignment: WrapAlignment.center, children: commands),
            Flexible(
                flex: 1,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: GitConsole(
                        cmdController: _cmdController,
                        cmdFocus: _cmdFocus,
                        lastCommandSucceeded: _lastCommandSucceeded,
                        resultController: _resultController,
                        runCommand: _runCommand,
                      ),
                    ),
                    const Expanded(
                      flex: 1,
                      child: PanelContainer(
                        title: 'Smart',
                        child: Expanded(child: CleverInfos()),
                      ),
                    ),
                  ],
                )),
            Flexible(
                flex: 3,
                child: Row(
                  children: const <Widget>[
                    Expanded(
                      flex: 1,
                      child: PanelContainer(
                        title: 'Files',
                        child: FileTree(path: './'),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: PanelContainer(
                        title: 'Commits',
                        child: CommitTree(),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: PanelContainer(
                        title: 'Status',
                        child: Expanded(child: RepositoryStatus()),
                      ),
                    ),
                  ],
                ))
          ])),
    );
  }
}
