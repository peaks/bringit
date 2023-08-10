/*
 * Copyright (c) 2020 Peaks
 *
 * This file is part of Brin'Git
 *
 * Brin'Git is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * Brin'Git is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with Brin'Git.  If not, see <http://www.gnu.org/licenses/>.
 */
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:git_ihm/presentation/widget/menu/side_menu.dart'
    as side_menu_custom;
import 'package:git_ihm/presentation/widget/shared/path_selector.dart';
import 'package:git_ihm/presentation/widget/status_bar/status_bar.dart';

import '../views/commits_view.dart';
import '../views/explorer_view.dart';
import '../views/staging_view.dart';

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
              padding: const EdgeInsets.all(4),
              //color: Theme.of(context).colorScheme.background,
              child: Image.asset(
                'assets/bg-compact.png',
                color: Theme.of(context).colorScheme.background,
                fit: BoxFit.fitHeight,
              )),
          title: Container(
            alignment: Alignment.centerLeft,
            child: Text(
              'Project 1',
              style: Theme.of(context).textTheme.titleLarge,
              //TextStyle(color: NordColors.$8, fontSize: 14),
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
              selectedIconColor: Theme.of(context).colorScheme.secondary,
              backgroundColor: Theme.of(context).colorScheme.surface,
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
                      StagingScreen(),
                      ExplorerScreen(),
                      CommitsScreen()
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
