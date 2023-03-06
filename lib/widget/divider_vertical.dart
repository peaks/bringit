import 'package:flutter/material.dart';

/// si on a un theme ce custom widget n'a plus lieu d'être
class DividerVertical extends StatelessWidget {
  const DividerVertical({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return VerticalDivider(
      color: Theme.of(context).primaryColorDark, //color of divider
      width: 2,
      thickness: 3,
      endIndent: 3, //width space of divider
    );
  }
}
