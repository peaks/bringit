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
      const TextStyle(fontSize: 16, fontFamily: 'FantasqueSansMono');

  final TextStyle _consoleStyle =
      const TextStyle(fontSize: 12, fontFamily: 'FantasqueSansMono');

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
            Row(
              children: <Widget>[
                const Expanded(
                    flex: 1,
                    child: Center(
                        child: Text(
                      'Files',
                      style: TextStyle(fontSize: 16),
                    ))),
                const Expanded(
                    flex: 1,
                    child: Center(
                        child: Text(
                      'Graph',
                      style: TextStyle(fontSize: 16),
                    ))),
                Expanded(
                    flex: 1,
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Flexible(
                                child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4.0),
                                    child: TextField(
                                      controller: _cmdController,
                                      focusNode: _cmdFocus,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'FantasqueSansMono'),
                                      textAlign: TextAlign.left,
                                      decoration: InputDecoration(
                                        prefixIcon: const Text(
                                          ' git ',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontFamily: 'FantasqueSansMono'),
                                        ),
                                        prefixIconConstraints:
                                            const BoxConstraints(
                                                minWidth: 0, minHeight: 0),
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
                                      onSubmitted: (String command) =>
                                          _runCommand(command),
                                    ))),
                            GIconButton(
                                onPressed: () =>
                                    _runCommand(_cmdController.text),
                                icon: Icons.keyboard_return),
                          ],
                        ),
                        Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Expanded(
                                child: TextField(
                              controller: _resultController,
                              enabled: false,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'FantasqueSansMono',
                                  color: _lastCommandSuccedeed
                                      ? Colors.white
                                      : Colors.redAccent),
                              textAlign: TextAlign.left,
                              maxLines: null,
                            ))),
                      ],
                    ))
              ],
            )
          ])),
    );
  }
}
