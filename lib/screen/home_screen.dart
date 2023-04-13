import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../widget/button/home_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(35.0),
        child: AppBar(
          elevation: 0,
          leadingWidth: 180,
          leading: Container(
              height: 35,
              child: Image.asset(
                'assets/gitguglogo.png',
                fit: BoxFit.fitHeight,
              )),
          title: Container(
            alignment: Alignment.centerLeft,
          ),
        ),
      ),
      body: Container(
        child: Center(
          child: HomeButton(
            title: 'Create Git Project',
            icon: MdiIcons.git,
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}
