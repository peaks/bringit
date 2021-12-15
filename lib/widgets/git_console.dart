import 'package:flutter/material.dart';
import 'package:git_ihm/widgets/git_console_input.dart';

class GitConsole extends StatelessWidget {
  GitConsole({
    required this.cmdController,
    required this.cmdFocus,
    required this.resultController,
    required this.lastCommandSuccedeed,
    required this.runCommand,
  });

  final TextEditingController cmdController;
  final FocusNode cmdFocus;
  final TextEditingController resultController;
  final bool lastCommandSuccedeed;
  final Function(String) runCommand;

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GitConsoleInput(
            cmdController: cmdController,
            cmdFocus: cmdFocus,
            lastCommandSuccedeed: lastCommandSuccedeed,
            runCommand: runCommand),
        Expanded(
            child: Scrollbar(
                controller: _scrollController, // <---- Here, the controller
                isAlwaysShown: true, // <---- Required
                child: SingleChildScrollView(
                    controller: _scrollController,
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: SingleChildScrollView(
                            child: TextField(
                          controller: resultController,
                          enabled: false,
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'FantasqueSansMono',
                              color: lastCommandSuccedeed
                                  ? Colors.white
                                  : Colors.redAccent),
                          textAlign: TextAlign.left,
                          maxLines: null,
                        ))))))
      ],
    );
  }
}
