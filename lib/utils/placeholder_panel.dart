import 'package:flutter/material.dart';
import 'package:git_ihm/widgets/scrollable_panel_container.dart';

class PlaceholderPanel extends StatelessWidget {
  const PlaceholderPanel(this.title, {Key? key, this.flex = 1})
      : super(
          key: key,
        );
  final String title;
  final int flex;

  @override
  Widget build(BuildContext context) {
    return ScrollablePanelContainer(
      flex: flex,
      title: title,
      child: Center(
        child: Text(
          title,
          style: const TextStyle(fontSize: 32),
        ),
      ),
    );
  }
}
