import 'package:flutter/material.dart';
import 'package:git_ihm/screen/explorer_layout.dart';
import 'package:git_ihm/screen/location_layout.dart';
import 'package:git_ihm/screen/project_tab_bar.dart';
import 'package:git_ihm/screen/side_menu.dart';
import 'package:git_ihm/screen/staging_layout.dart';
import 'package:git_ihm/screen/status_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<NavigationItem> navigationItems = <NavigationItem>[
    NavigationItem(
        child: const StagingLayout(),
        icon: const Icon(Icons.difference_outlined),
        label: 'Staging'),
    NavigationItem(
        child: const ExplorerLayout(),
        icon: const Icon(Icons.folder_open_outlined),
        label: 'Explorer'),
    NavigationItem(
        child: const LocationLayout(),
        icon: const Icon(Icons.commit_rounded),
        label: 'Location'),
  ];
  late int selectedItem;

  @override
  void initState() {
    super.initState();
    selectedItem = 0;
  }

  void selectItem(int index) {
    setState(() {
      selectedItem = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          const ProjectTabBar(),
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                SideMenu(
                  navigationItems: navigationItems,
                  onDestinationSelected: selectItem,
                ),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      navigationItems.elementAt(selectedItem).child,
                      const StatusBar(),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
