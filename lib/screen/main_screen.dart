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
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(right: 15),
          child: Image.asset(
            'assets/gitlogo.png',
            width: 200,
            height: 200,
          ),
        ),
        title: const Text(
          'Project 1',
          style: TextStyle(color: NordColors.$8),
        ),
        actions: const <Widget>[PathSelector()],
      ),
      body: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          SideMenu(
            style: SideMenuStyle(
                displayMode: SideMenuDisplayMode.compact,
                hoverColor: NordColors.$2,
                selectedIconColor: Colors.white,
                unselectedIconColor: Colors.grey,
                backgroundColor: NordColors.$3,
                compactSideMenuWidth: 70,
                iconSize: 25,
                itemBorderRadius: const BorderRadius.all(
                  Radius.circular(5.0),
                ),
                showTooltip: true,
                itemHeight: 60.0,
                itemInnerSpacing: 8.0,
                itemOuterPadding: const EdgeInsets.all(5.0),
                toggleColor: Colors.black54),
            controller: sideMenu,
            items: [
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
              const SideMenuItem(
                priority: 7,
                icon: Icon(Icons.exit_to_app),
              ),
            ],
          ),
          Expanded(
            child: PageView(
              controller: page,
              children: [StagingLayout(), ExplorerLayout(), LocationLayout(), StatusBar()],
            ),
          ),
        ],
      ),
    );
  }
}
