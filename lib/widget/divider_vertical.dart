import 'package:flutter/material.dart';

/// si on a un theme ce custom widget n'a plus lieu d'être
class DividerVertical extends StatelessWidget {
  const DividerVertical({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const VerticalDivider(
      width: 2, //width space of divider
    );
  }
}
