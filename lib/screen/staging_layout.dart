import 'package:flutter/cupertino.dart';
import 'package:git_ihm/utils/placeholder_panel.dart';
import 'package:git_ihm/widget/divider_vertical.dart';

class StagingLayout extends StatelessWidget {
  const StagingLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Column(children: const <Widget>[
              PlaceholderPanel(
                'Staging',
              ),
              // StagingGButton(),
              PlaceholderPanel(
                'Diff',
              ),
            ]),
          ),
          const DividerVertical(),
          Expanded(
            child: Column(children: const <Widget>[
              PlaceholderPanel(
                'Commits',
                flex: 2,
              ),
              PlaceholderPanel(
                'Console',
              ),
            ]),
          ),
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
