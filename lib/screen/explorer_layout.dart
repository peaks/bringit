import 'package:flutter/cupertino.dart';
import 'package:git_ihm/utils/placeholder_panel.dart';

class ExplorerLayout extends StatelessWidget {
  const ExplorerLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: <Expanded>[
          Expanded(
            flex: 2,
            child: Column(children: const <Widget>[
              PlaceholderPanel(
                'File Viewer',
              ),
            ]),
          ),
          Expanded(
            child: Column(children: const <Widget>[
              PlaceholderPanel(
                'Explorer',
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
