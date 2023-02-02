import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nord_theme/flutter_nord_theme.dart';
import 'package:git_ihm/screen/explorer_layout.dart';
import 'package:git_ihm/screen/location_layout.dart';
import 'package:git_ihm/screen/staging_layout.dart';
import 'package:git_ihm/screen/status_bar.dart';
import 'package:git_ihm/widget/path_selector.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    super.initState();
    sideMenu.addListener((int p0) {
      page.jumpToPage(p0);
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
          SideMenu(
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
                    children: const <Widget>[StagingLayout(), ExplorerLayout(), LocationLayout()],
                  ),
                ),
                // statusBAr placed here to stay whatever content is displayed
                const StatusBar()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
