import 'package:flutter/cupertino.dart';
import 'package:git_ihm/utils/placeholder_panel.dart';
import 'package:git_ihm/widget/divider_vertical.dart';

class LocationLayout extends StatelessWidget {
  const LocationLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Column(children: const <Widget>[
              PlaceholderPanel(
                'Commits',
              ),
            ]),
          ),
          const DividerVertical(),
          Expanded(
            child: Column(children: const <Widget>[
              PlaceholderPanel(
                'Locations',
                flex: 2,
              ),
              PlaceholderPanel(
                'Console',
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
