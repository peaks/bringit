import 'package:flutter/cupertino.dart';
import 'package:git_ihm/widget/divider_vertical.dart';
import 'package:git_ihm/widget/scrollable_panel_container.dart';
import 'package:git_ihm/widget/staging_g_button.dart';

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
              ScrollablePanelContainer(
                title: 'Staging',
                child: Center(
                  child: Text(
                    'Content',
                    style: const TextStyle(fontSize: 32),
                  ),
                ),
              ),
              Expanded(
                child: StagingGButton(),
              ),
              ScrollablePanelContainer(
                title: 'Diff',
                child: Center(
                  child: Text(
                    'Content',
                    style: const TextStyle(fontSize: 32),
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
                  title: 'Commits',
                  child: Center(
                    child: Text(
                      'Content',
                      style: const TextStyle(fontSize: 32),
                    ),
                  ),
                ),
                ScrollablePanelContainer(
                  title: 'Console',
                  child: Center(
                    child: Text(
                      'Content',
                      style: const TextStyle(fontSize: 32),
                    ),
                  ),
                ),
              ])),
          // Expanded(
          //   flex: 2,
          //   child: Column(children: <PlaceholderPanel>[
          //     PlaceholderPanel('Staging'),
          //     PlaceholderPanel('Diff'),
          //   ]),
          // ),
          // Expanded(
          //   flex: 1,
          //   child: Column(children: <PlaceholderPanel>[
          //     PlaceholderPanel('Commits', flex: 2),
          //     PlaceholderPanel('Console'),
          //   ]),
          // ),
        ],
      ),
    );
  }
}
