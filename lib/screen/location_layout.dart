import 'package:flutter/cupertino.dart';
import 'package:git_ihm/utils/placeholder_panel.dart';

class LocationLayout extends StatelessWidget {
  const LocationLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: <Expanded>[
          Expanded(
            flex: 2,
            child: Column(children: const <Widget>[
              PlaceholderPanel(
                'Commits',
              ),
            ]),
          ),
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
