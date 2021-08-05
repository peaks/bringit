import 'dart:io';

import 'package:flutter/material.dart';

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

  void _runCommand() {
    final ProcessResult result = Process.runSync(
        'git', _cmdController.text.split(' '),
        workingDirectory: './test/test_repository');
    _stdoutController.text = result.stdout.toString();
    _stderrController.text = result.stderr.toString();
    setState(() {
      _lastCommandSuccedeed = result.exitCode == 0;
    });
    _cmdController.clear();
    _cmdFocus.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(children: [
            Column(children: <Widget>[
              const Text(
                'It\'s Git Time!',
                style: TextStyle(fontSize: 64, fontWeight: FontWeight.bold),
              ),
              Row(
                children: <Widget>[
                  const Text(
                    'git',
                    style: TextStyle(fontSize: 32),
                    textAlign: TextAlign.right,
                  ),
                  Expanded(
                      child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: TextField(
                            controller: _cmdController,
                            focusNode: _cmdFocus,
                            style: const TextStyle(fontSize: 32),
                            textAlign: TextAlign.left,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: _lastCommandSuccedeed
                                        ? Colors.greenAccent
                                        : Colors.redAccent,
                                    width: 0.0),
                              ),
                            ),
                            onSubmitted: (_) => _runCommand(),
                          ))),
                  TextButton(
                      onPressed: () => _runCommand(),
                      child: const Icon(Icons.keyboard_return))
                ],
              ),
              TextField(
                controller: _stdoutController,
                enabled: false,
                style: const TextStyle(fontSize: 24),
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
              ),
              TextField(
                controller: _stderrController,
                enabled: false,
                style: const TextStyle(fontSize: 24, color: Colors.redAccent),
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
              )
            ])
          ])),
    );
  }
}
