import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nord_theme/flutter_nord_theme.dart';
import 'package:git_ihm/helpers/wording.dart';
import 'package:git_ihm/screen/screenTemplate.dart';
import 'package:git_ihm/widget/button/staging_g_button.dart';
import 'package:git_ihm/widget/commit_summary.dart';
import 'package:git_ihm/widget/file_tree.dart';
import 'package:git_ihm/widget/path_selector.dart';
import 'package:git_ihm/widget/scrollable_panel_container.dart';
import 'package:git_ihm/widget/side_menu.dart' as side_menu_custom;
import 'package:git_ihm/widget/status_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Widget>? stagingChildren;
  List<Widget>? explorerChildren;
  List<Widget>? commitsChildren;

  @override
  void initState() {
    super.initState();
    sideMenu.addListener((int p0) {
      page.jumpToPage(p0);
    });
    buildChildren();
  }

  void buildChildren() {
    setState(() {
      stagingChildren = <Widget>[
        const ScrollablePanelContainer(
          flex: 1,
          title: Wording.stagingBlockTitle,
          child: Center(
            child: Text(
              'Content',
              style: TextStyle(fontSize: 32),
            ),
          ),
          footer: StagingGButton(),
        ),
        const ScrollablePanelContainer(
          title: Wording.diffBlockTitle,
          child: Center(
            child: Text(
              'Content',
              style: TextStyle(fontSize: 32),
            ),
          ),
        ),
        const ScrollablePanelContainer(
          flex: 2,
          title: Wording.commitBlockTitle,
          child: Center(
            child: Text(
              'Content',
              style: TextStyle(fontSize: 32),
            ),
          ),
        )
      ];

      explorerChildren = <Widget>[
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

      commitsChildren = <Widget>[
        const ScrollablePanelContainer(
          title: Wording.commitBlockTitle,
          child: Center(
            child: Text(
              'Content',
              style: TextStyle(fontSize: 32),
            ),
          ),
        ),
        ScrollablePanelContainer(
          title: Wording.commitSummaryBlockTitle,
          child: CommitSummary(
            commitHash: '454fdf5d',
          ),
        ),
        const ScrollablePanelContainer(
          flex: 2,
          title: Wording.locationBlockTitle,
          child: Center(
            child: Text(
              'Content',
              style: TextStyle(fontSize: 32),
            ),
          ),
        ),
      ];
    });
  }

  PageController page = PageController();
  SideMenuController sideMenu = SideMenuController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // add preferredSize to customise appbar height
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(35.0),
        // appbar widget to us here instead of top widget in body
        child: AppBar(
          elevation: 0,
          leadingWidth: 100,
          leading: Container(
              height: 35,
              child: Image.asset(
                'assets/gitlogo.png',
                fit: BoxFit.fitHeight,
              )),
          title: Container(
            alignment: Alignment.centerLeft,
            child: const Text(
              'Project 1',
              style: TextStyle(color: NordColors.$8, fontSize: 14),
            ),
          ),
          // actions in appbar to add buttons here the selection of the  project's path
          actions: const <Widget>[PathSelector()],
        ),
      ),
      body: Row(
        children: <Widget>[
          // flutter library added in pubspec.yaml
          // library offer a lot of possibilities
          // collapsing & labels etc
          side_menu_custom.SideMenu(
            style: SideMenuStyle(
              displayMode: SideMenuDisplayMode.compact,
              selectedIconColor: NordColors.$8,
              backgroundColor: NordColors.$3,
              selectedColor: Colors.transparent,
              compactSideMenuWidth: 70,
              iconSize: 25,
              itemHeight: 60.0,
              itemInnerSpacing: 8.0,
              itemOuterPadding: const EdgeInsets.all(5.0),
            ),
            controller: sideMenu,
            items: <SideMenuItem>[
              SideMenuItem(
                priority: 0,
                onTap: (int page, _) {
                  sideMenu.changePage(page);
                },
                icon: const Icon(Icons.difference_outlined),
              ),
              SideMenuItem(
                priority: 1,
                onTap: (int page, _) {
                  sideMenu.changePage(page);
                },
                icon: const Icon(Icons.folder_open_outlined),
              ),
              SideMenuItem(
                priority: 2,
                onTap: (int page, _) {
                  sideMenu.changePage(page);
                },
                icon: const Icon(Icons.commit_rounded),
              ),
            ],
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                Expanded(
                  // use pageview when menu nav is used to switch body display on same Scaffold screen
                  child: PageView(
                    controller: page,
                    children: <Widget>[
                      ScreenTemplate(sections: 2, title: Wording.stagingScreenTitle, children: stagingChildren!),
                      ScreenTemplate(sections: 1, title: Wording.explorerScreenTitle, children: explorerChildren!),
                      ScreenTemplate(sections: 2, title: Wording.locationScreenTitle, children: commitsChildren!)
                    ],
                  ),
                ),
                // statusBar placed here to stay whatever content is displayed
                const StatusBar()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
