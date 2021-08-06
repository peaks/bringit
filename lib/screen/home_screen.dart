import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  final TextEditingController _stdoutController = TextEditingController();
  final TextEditingController _stderrController = TextEditingController();
  bool _lastCommandSuccedeed = true;

  void _runCommand(String command) {
    final ProcessResult result =
        Process.runSync('git', command.split(' '), workingDirectory: './');
    _stdoutController.text = result.stdout.toString();
    _stderrController.text = result.stderr.toString();
    setState(() {
      _lastCommandSuccedeed = result.exitCode == 0;
    });
    _cmdController.clear();
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
            Row(children: <Widget>[
              CommandButton(
                title: 'STATUS',
                onPressed: () => _setCurrentCommand('status'),
              ),
              CommandButton(
                title: 'LOG',
                onPressed: () => _setCurrentCommand('log'),
              ),
              CommandButton(
                title: 'DIFF',
                onPressed: () => _setCurrentCommand('diff'),
              ),
            ]),
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
                flex: 3,
                child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: TextField(
                      controller: _stdoutController,
                      enabled: false,
                      style: _consoleStyle,
                      textAlign: TextAlign.left,
                      minLines: 20,
                      maxLines: 20,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: _lastCommandSuccedeed
                                    ? Colors.greenAccent
                                    : Colors.redAccent)),
                      ),
                    ))),
            Expanded(
                flex: 1,
                child: TextField(
                  controller: _stderrController,
                  enabled: false,
                  style: _consoleStyle
                      .merge(const TextStyle(color: Colors.redAccent)),
                  textAlign: TextAlign.left,
                  minLines: 2,
                  maxLines: 2,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: _lastCommandSuccedeed
                                ? Colors.greenAccent
                                : Colors.redAccent)),
                  ),
                ))
          ])),
    );
  }
}
