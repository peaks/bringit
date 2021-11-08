import 'package:flutter/material.dart';
import 'package:git_ihm/widgets/button/icon_button.dart';

class GitConsole extends StatelessWidget {
  const GitConsole({
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
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
        ),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Expanded(
                child: TextField(
              controller: resultController,
              enabled: false,
              style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'FantasqueSansMono',
                  color:
                      lastCommandSuccedeed ? Colors.white : Colors.redAccent),
              textAlign: TextAlign.left,
              maxLines: null,
            ))),
      ],
    );
  }
}
