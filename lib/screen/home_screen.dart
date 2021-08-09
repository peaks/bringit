import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:git_ihm/utils/command_level_enum.dart';
import 'package:git_ihm/widgets/button/command_button.dart';
import 'package:git_ihm/widgets/button/icon_button.dart';

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

  final TextStyle _commandStyle =
      const TextStyle(fontSize: 32, fontFamily: 'FantasqueSansMono');

  final TextStyle _consoleStyle =
      const TextStyle(fontSize: 24, fontFamily: 'FantasqueSansMono');

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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(children: <Widget>[
            const Text(
              'It\'s Git Time!',
              style: TextStyle(fontSize: 64, fontWeight: FontWeight.bold),
            ),
            Wrap(
                alignment: WrapAlignment.center,
                children: infoCommands
                    .map((String command) => CommandButton(
                          title: command,
                          onPressed: () => _runCommand(command),
                          level: CommandLevel.info,
                        ))
                    .toList()),
            Wrap(
                alignment: WrapAlignment.center,
                children: remoteCommands
                    .map((String command) => CommandButton(
                        title: command,
                        onPressed: () => _runCommand(command),
                        level: CommandLevel.remote))
                    .toList()),
            Wrap(
                alignment: WrapAlignment.center,
                children: safeCommands
                    .map((String command) => CommandButton(
                        title: command,
                        onPressed: () => _runCommand(command),
                        level: CommandLevel.safe))
                    .toList()),
            Wrap(
                alignment: WrapAlignment.center,
                children: dangerousCommands
                    .map((String command) => CommandButton(
                        title: command,
                        onPressed: () => _runCommand(command),
                        level: CommandLevel.dangerous))
                    .toList()),
            Row(
              children: <Widget>[
                Expanded(
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: TextField(
                          controller: _cmdController,
                          focusNode: _cmdFocus,
                          style: _commandStyle,
                          textAlign: TextAlign.left,
                          decoration: InputDecoration(
                            prefixIcon: Text(
                              ' git ',
                              style: _commandStyle,
                            ),
                            prefixIconConstraints:
                                const BoxConstraints(minWidth: 0, minHeight: 0),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: _lastCommandSuccedeed
                                      ? Colors.greenAccent
                                      : Colors.redAccent,
                                  width: 0.0),
                            ),
                          ),
                          onSubmitted: (String command) => _runCommand(command),
                        ))),
                GIconButton(
                    onPressed: () => _runCommand(_cmdController.text),
                    icon: Icons.keyboard_return)
              ],
            ),
            Expanded(
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: TextField(
                          controller: _resultController,
                          enabled: false,
                          style: _consoleStyle.merge(TextStyle(
                              color: _lastCommandSuccedeed
                                  ? Colors.white
                                  : Colors.redAccent)),
                          textAlign: TextAlign.left,
                          maxLines: null,
                        )))),
          ])),
    );
  }
}
