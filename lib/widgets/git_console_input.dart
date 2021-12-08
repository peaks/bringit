import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:git_ihm/widgets/button/icon_button.dart';

class GitConsoleInput extends StatelessWidget {
  const GitConsoleInput({
    Key? key,
    required this.cmdController,
    required this.cmdFocus,
    required this.lastCommandSuccedeed,
    required this.runCommand,
  }) : super(key: key);

  final TextEditingController cmdController;
  final FocusNode cmdFocus;
  final bool lastCommandSuccedeed;
  final Function(String p1) runCommand;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Flexible(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: TextField(
                  controller: cmdController,
                  focusNode: cmdFocus,
                  style: const TextStyle(
                      fontSize: 16, fontFamily: 'FantasqueSansMono'),
                  textAlign: TextAlign.left,
                  decoration: InputDecoration(
                    prefixIcon: const Text(
                      ' git ',
                      style: TextStyle(
                          fontSize: 16, fontFamily: 'FantasqueSansMono'),
                    ),
                    prefixIconConstraints:
                        const BoxConstraints(minWidth: 0, minHeight: 0),
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: lastCommandSuccedeed
                              ? Colors.greenAccent
                              : Colors.redAccent,
                          width: 0.0),
                    ),
                  ),
                  onSubmitted: (String command) => runCommand(command),
                ))),
        GIconButton(
            onPressed: () => runCommand(cmdController.text),
            icon: Icons.keyboard_return),
      ],
    );
  }
}
