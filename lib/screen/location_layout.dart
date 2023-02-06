import 'package:flutter/cupertino.dart';
import 'package:git_ihm/widget/divider_vertical.dart';
import 'package:git_ihm/widget/scrollable_panel_container.dart';

class LocationLayout extends StatelessWidget {
  const LocationLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
              flex: 2,
              child: Column(children: const <Widget>[
                ScrollablePanelContainer(
                  title: 'Commits',
                  child: Center(
                    child: Text(
                      'Content',
                      style: TextStyle(fontSize: 32),
                    ),
                  ),
                ),
              ])),
          const DividerVertical(),
          Expanded(
              flex: 1,
              child: Column(children: const <Widget>[
                ScrollablePanelContainer(
                  flex: 2,
                  title: 'Locations',
                  child: Center(
                    child: Text(
                      'Content',
                      style: TextStyle(fontSize: 32),
                    ),
                  ),
                ),
                ScrollablePanelContainer(
                  title: 'Console',
                  child: Center(
                    child: Text(
                      'Content',
                      style: TextStyle(fontSize: 32),
                    ),
                  ),
                ),
              ])),
        ],
      ),
    );
  }
}
