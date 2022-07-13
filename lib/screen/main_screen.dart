import 'package:flutter/material.dart';
import 'package:git_ihm/screen/staging_layout.dart';

class MainScreen extends StatelessWidget {
  MainScreen({Key? key}) : super(key: key);

  final Row _statusBar = Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: const <Widget>[
      Text('STATUS BAR'),
    ],
  );

  final NavigationRail _navigation = NavigationRail(
    selectedIndex: 0,
    onDestinationSelected: (_) {},
    destinations: const <NavigationRailDestination>[
      NavigationRailDestination(
        icon: Icon(
          Icons.difference_outlined,
          size: 48,
        ),
        label: Text('Staging'),
      ),
      NavigationRailDestination(
        icon: Icon(Icons.folder_outlined),
        label: Text('Explorer'),
      ),
    ],
  );

  final Container _tabBar = Container(
    alignment: AlignmentDirectional.centerStart,
    padding: const EdgeInsets.all(8),
    child: const Text('Project 1'),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          _tabBar,
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                _navigation,
                Expanded(
                    child: Column(
                  children: <Widget>[const StagingLayout(), _statusBar],
                ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
