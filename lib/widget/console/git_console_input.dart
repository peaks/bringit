import 'package:flutter/material.dart';
import 'package:flutter_nord_theme/flutter_nord_theme.dart';

class GitConsoleInput extends StatelessWidget {
  const GitConsoleInput({
    Key? key,
    required this.cmdController,
    required this.cmdFocus,
    required this.lastCommandSucceeded,
    required this.runCommand,
  }) : super(key: key);

  final TextEditingController cmdController;
  final FocusNode cmdFocus;
  final bool lastCommandSucceeded;
  final Function(String p1) runCommand;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: NordColors.$1,
      padding: const EdgeInsets.all(8),
      child: Row(
        children: <Widget>[
          Flexible(
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: TextField(
                    controller: cmdController,
                    focusNode: cmdFocus,
                    style: const TextStyle(fontSize: 16, fontFamily: 'FantasqueSansMono'),
                    textAlign: TextAlign.left,
                    decoration: const InputDecoration(
                      prefixIcon: Text(
                        ' git ',
                        style: TextStyle(fontSize: 16, fontFamily: 'FantasqueSansMono'),
                      ),
                      prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
                    ),
                    onSubmitted: (String command) => runCommand(command),
                  ))),
        ],
      ),
    );
  }
}
