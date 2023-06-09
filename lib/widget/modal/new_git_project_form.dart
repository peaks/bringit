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
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:git_ihm/widget/button/modal_action_button.dart';
import 'package:git_ihm/widget/texfield/textfield_project_name.dart';

import '../../screen/main_screen.dart';
import '../texfield/textfield_select_folder_path.dart';

class NewGitProjectForm extends StatefulWidget {
  const NewGitProjectForm({Key? key}) : super(key: key);

  @override
  State<NewGitProjectForm> createState() => _NewGitProjectFormState();
}

class _NewGitProjectFormState extends State<NewGitProjectForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late String newProjectPath = '';
  late String projectNameMessageError = '';
  bool isProjectPathValid = false;
  bool isProjectNameValid = true;
  bool isProjectNameNotYetModified = true;

  final TextEditingController pathDirectoryController = TextEditingController();
  String? selectedDirectory;

  void setValidatorProjectName(bool valid) {
    setState(() {
      isProjectNameValid = valid;
    });
  }

  String getErrorMessageForPathName(
      bool pathAlreadyExists, bool isValidProjectName) {
    if (!isValidProjectName) {
      return 'is not a valid project name';
    }
    if (pathAlreadyExists) {
      return 'already exists';
    }
    return '';
  }

  void setValidatorPathAlreadyExists(bool pathAlreadyExists) {
    setState(() {
      isProjectPathValid = pathAlreadyExists;
    });
  }

  Future<void> onProjectNameChanged(String? val) async {
    projectNameMessageError = '';
    final String pathDirectory = pathDirectoryController.text;
    final String pathToNewProject = '$pathDirectory/$val';
    isProjectNameNotYetModified = false;

    if (val!.isEmpty) {
      projectNameMessageError = '$val is not a valid project name';
      isProjectNameValid = false;
    } else {
      isProjectNameValid = true;
      final bool isPathExisting = Directory(pathToNewProject).existsSync();
      if (isPathExisting) {
        projectNameMessageError = '$pathToNewProject already exists';
        isProjectNameValid = false;
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          TextfieldSelectFolderPath(
            isProjectPathValid: isProjectPathValid,
            label: 'Parent Folder',
            pathDirectoryController: pathDirectoryController,
          ),
          TextfieldProjectName(
            isProjectNameValid: isProjectNameValid,
            isProjectNameNotYetModified: isProjectNameNotYetModified,
            pathDirectoryController: pathDirectoryController,
            onProjectNameChanged: onProjectNameChanged,
            projectNameMessageError: projectNameMessageError,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 14.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                    child: ModalActionButton(
                  onSubmit: () {
                    Navigator.of(context).pop();
                  },
                  title: 'Cancel',
                )),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                    child: ModalActionButton(
                  onSubmit: () {
                    Navigator.push<MaterialPageRoute<dynamic>>(
                        context,
                        MaterialPageRoute<MaterialPageRoute<dynamic>>(
                            builder: (BuildContext context) =>
                                const MainScreen()));
                  },
                  enable: isProjectNameValid && !isProjectNameNotYetModified,
                  title: 'Create',
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
