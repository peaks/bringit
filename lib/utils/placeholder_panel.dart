import 'package:flutter/material.dart';
import 'package:flutter_nord_theme/flutter_nord_theme.dart';
import 'package:git_ihm/widget/scrollable_panel_container.dart';

class PlaceholderPanel extends StatelessWidget {
  const PlaceholderPanel(this.title,
      {Key? key, this.flex = 1, this.widget = const Text('')})
      : super(
          key: key,
        );
  final String title;
  final int flex;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return ScrollablePanelContainer(
      backgroundColor: NordColors.$1,
      flex: flex,
      title: title,
      child: widget,
    );
  }
}
