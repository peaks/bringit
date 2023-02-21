import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:git_ihm/widget/button/staging_g_button.dart';
import 'package:git_ihm/widget/divider_vertical.dart';
import 'package:git_ihm/widget/scrollable_panel_container.dart';

class StagingLayout extends StatelessWidget {
  const StagingLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Column(children: const <Widget>[
              // removed PlaceholderPanel because useless just extra layer
              ScrollablePanelContainer(
                flex: 1,
                title: 'Staging',
                child: Center(
                  child: Text(
                    'Content',
                    style: TextStyle(fontSize: 32),
                  ),
                ),
              ),
              StagingGButton(),
              ScrollablePanelContainer(
                flex: 1,
                title: 'Diff',
                child: Center(
                  child: Text(
                    'Content',
                    style: TextStyle(fontSize: 32),
                  ),
                ),
              ),
            ]),
          ),
          const DividerVertical(),
          Expanded(
              flex: 1,
              child: Column(children: const <Widget>[
                ScrollablePanelContainer(
                  flex: 2,
                  title: 'Commits',
                  child: Center(
                    child: Text(
                      'Content',
                      style: TextStyle(fontSize: 32),
                    ),
                  ),
                ),
                ScrollablePanelContainer(
                  flex: 1,
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
