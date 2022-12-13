import 'package:flutter/material.dart';
import 'package:git_ihm/utils/command_level_enum.dart';

class CommandButton extends StatelessWidget {
  CommandButton(
      {required this.title,
      required this.onPressed,
      this.level = CommandLevel.unknown});
  final String title;
  final GestureTapCallback onPressed;
  final CommandLevel level;

  final Map<CommandLevel, Color> colorByLevel = <CommandLevel, Color>{
    CommandLevel.unknown: Colors.grey,
    CommandLevel.info: Colors.blue,
    CommandLevel.remote: Colors.orange,
    CommandLevel.safe: Colors.green,
    CommandLevel.dangerous: Colors.red,
  };

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: RawMaterialButton(
          fillColor: colorByLevel[level],
          splashColor: colorByLevel[level],
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              maxLines: 1,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          onPressed: onPressed,
          shape: const StadiumBorder(),
        ));
  }
}
