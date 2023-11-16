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
import 'package:git_ihm/domain/git/git_factory.dart';
import 'package:git_ihm/domain/git/git_proxy.dart';
import 'package:git_ihm/helpers/git_gud_logger.dart';
import 'package:git_ihm/helpers/localization/wording.dart';
import 'package:git_ihm/ui/common/widget/shared/button/modal_action_button.dart';
import 'package:logger/logger.dart';

import '../../../screens/main_screen.dart';
import '../shared/textfield/textfield_select_folder_path.dart';

class OpenProjectForm extends StatefulWidget {
  const OpenProjectForm({Key? key}) : super(key: key);

  @override
  State<OpenProjectForm> createState() => _OpenProjectFormState();
}

class _OpenProjectFormState extends State<OpenProjectForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String pathToProject = '';
  String? folderSelectedMessageError;
  bool isProjectNameNotYetModified = true;
  bool isAGitProject = false;
  late GitProxy git;

  final TextEditingController pathDirectoryController = TextEditingController();

  String? selectedDirectory;

  late Logger _log;

  @override
  void initState() {
    _log = getLogger(runtimeType.toString());
    GitFactory().getGit().then((GitProxy gitP) {
      setState(() {
        git = gitP;
      });
    });
    pathDirectoryController.addListener(updateFolderStatus);
    super.initState();
  }

  Future<void> updateFolderStatus() async {
    pathToProject = pathDirectoryController.text;
    isAGitProject = await git.isGitDir(pathToProject);
    _log.d('$pathToProject is ${isAGitProject ? '' : 'not '}a git repository');
    if (!isAGitProject) {
      folderSelectedMessageError =
          Wording.modalOpenGitProjectErrorMessageNotAGitRepository;
    } else {
      folderSelectedMessageError = null;
    }
    setState(() {
      pathToProject = pathToProject;
      isAGitProject = isAGitProject;
      folderSelectedMessageError = folderSelectedMessageError;
    });
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
            isProjectPathValid: isAGitProject,
            label: Wording.modalOpenGitProjectTextfieldSelectFolderPathLabel,
            pathDirectoryController: pathDirectoryController,
            errorMessage: folderSelectedMessageError,
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
                        title: Wording.modalOpenGitProjectCancelButtonTitle)),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                    child: ModalActionButton(
                  onSubmit: () {
                    git.path = pathToProject;
                    Navigator.push<MaterialPageRoute<dynamic>>(
                        context,
                        MaterialPageRoute<MaterialPageRoute<dynamic>>(
                            builder: (BuildContext context) =>
                                const MainScreen()));
                  },
                  enable: isAGitProject,
                  title: Wording.modalOpenGitProjectOpenButtonTitle,
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
