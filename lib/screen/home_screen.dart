/*
 * Copyright (c) 2020 Peaks
 *
 * This file is part of GitGud
 *
 * GitGud is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * GitGud is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with GitGud.  If not, see <http://www.gnu.org/licenses/>.
 */
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
      builder: (BuildContext context) => NewProjectModal(
        icon: MdiIcons.git,
        modalContent: const NewGitProjectForm(),
        title: 'Create Git Project',
        onSubmit: () {},
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
