import 'package:flutter/material.dart';
import 'package:git_ihm/widget/modal/new_git_project_form.dart';
import 'package:git_ihm/widget/modal/new_modal.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../widget/button/home_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void displayModalCreateNewGitProject() {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => NewModal(
        icon: MdiIcons.git,
        modalContent: const NewGitProjectForm(),
        title: 'Create Git Project',
        onPressed: () {},
        titleAction: 'Create',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(35.0),
        child: AppBar(
          elevation: 0,
          leadingWidth: 180,
          leading: Container(
              child: Image.asset(
            'assets/gitguglogo.png',
            fit: BoxFit.fill,
          )),
        ),
      ),
      body: Container(
        child: Center(
          child: HomeButton(
            title: 'Create Git Project',
            icon: MdiIcons.git,
            onPressed: () {
              displayModalCreateNewGitProject();
            },
          ),
        ),
      ),
    );
  }
}
