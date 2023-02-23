import 'package:flutter/material.dart';
import 'package:git_ihm/helpers/wording.dart';
import 'package:git_ihm/screen/screenTemplate.dart';
import 'package:git_ihm/widget/scrollable_panel_container.dart';

import '../widget/file_tree.dart';

class ExplorerLayout extends StatelessWidget {
  ExplorerLayout({Key? key}) : super(key: key);

  final List<Widget> explorerChildren = <Widget>[
    const ScrollablePanelContainer(
      title: Wording.previewBlockTitle,
      child: Center(
        child: Text(
          'Content',
          style: TextStyle(fontSize: 32),
        ),
      ),
    ),
    const ScrollablePanelContainer(
      flex: 2,
      title: Wording.explorerBlockTitle,
      child: FileTree(),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return ScreenTemplate(sections: 1, children: explorerChildren);
  }
}
