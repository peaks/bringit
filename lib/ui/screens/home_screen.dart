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
import 'package:flutter/material.dart';
import 'package:git_ihm/helpers/localization/wording.dart';
import 'package:git_ihm/ui/common/widget/modal/modal_license_notice.dart';
import 'package:git_ihm/ui/common/widget/modal/new_git_project_form.dart';
import 'package:git_ihm/ui/common/widget/modal/new_modal.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../common/widget/shared/button/home_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final SharedPreferences sharedPreferences;

  void displayModalCreateNewGitProject() {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => NewProjectModal(
        icon: MdiIcons.git,
        modalContent: const NewGitProjectForm(),
        title: Wording.modalCreateNewGitProjectTitle,
        onSubmit: () {},
        titleAction: Wording.homeScreenCreateGitProjectButtonTitle,
      ),
    );
  }

  void displayModalAlertLicense() {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => ModalLicenseNotice(sharedPreferences),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((Duration timeStamp) {
      initFirstLaunch();
    });
  }

  Future<void> initFirstLaunch() async {
    sharedPreferences = await SharedPreferences.getInstance();
    final bool isFirstLaunch =
        sharedPreferences.getBool('isFirstLaunch') ?? true;
    if (isFirstLaunch) {
      displayModalAlertLicense();
      await sharedPreferences.setBool('isFirstLaunch', false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(35.0),
        child: AppBar(
          elevation: 0,
          leadingWidth: 200,
          leading: Container(
              padding: const EdgeInsets.all(4),
              child: Image.asset(
                'assets/bg-full.png',
                color: Theme.of(context).colorScheme.background,
                fit: BoxFit.fitHeight,
              )),
        ),
      ),
      body: Container(
        child: Center(
          child: HomeButton(
            title: Wording.homeScreenCreateGitProjectButtonTitle,
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
