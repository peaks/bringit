import 'package:flutter/material.dart';
import 'package:flutter_nord_theme/flutter_nord_theme.dart';

/// si on a un theme ce custom widget n'a plus lieu d'être
class DividerVertical extends StatelessWidget {
  const DividerVertical({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const VerticalDivider(
      color: NordColors.$0, //color of divider
      width: 2,
      endIndent: 10, //width space of divider
    );
  }
}
