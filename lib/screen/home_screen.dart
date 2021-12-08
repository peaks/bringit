import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:git_ihm/utils/command_level_enum.dart';
import 'package:git_ihm/widgets/CommitGraph.dart';
import 'package:git_ihm/widgets/FileTree.dart';
import 'package:git_ihm/widgets/GitConsole.dart';
import 'package:git_ihm/widgets/button/command_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _cmdController = TextEditingController();
  final FocusNode _cmdFocus = FocusNode();
  final TextEditingController _resultController = TextEditingController();
  bool _lastCommandSuccedeed = true;

  void _runCommand(String command) {
    _setCurrentCommand(command);
    final ProcessResult result =
        Process.runSync('git', command.split(' '), workingDirectory: './');
    _resultController.text =
        result.stderr.toString() + result.stdout.toString();
    result.stderr.toString();
    setState(() {
      _lastCommandSuccedeed = result.exitCode == 0;
    });
    _cmdFocus.requestFocus();
  }

  void _setCurrentCommand(String command) {
    _cmdController.text = command;
    _cmdFocus.requestFocus();
    _cmdController.selection = TextSelection.fromPosition(
        TextPosition(offset: _cmdController.text.length));
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

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
            const Text(
              'It\'s Git Time!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Wrap(alignment: WrapAlignment.center, children: commands),
            Expanded(
                child: Row(
              children: <Widget>[
                const Flexible(
                    flex: 1, child: Center(child: FileTree(path: './'))),
                const Flexible(flex: 1, child: Center(child: CommitTree())),
                Flexible(
                    flex: 1,
                    child: GitConsole(
                      cmdController: _cmdController,
                      cmdFocus: _cmdFocus,
                      lastCommandSuccedeed: _lastCommandSuccedeed,
                      resultController: _resultController,
                      runCommand: _runCommand,
                    ))
              ],
            ))
          ])),
    );
  }
}
