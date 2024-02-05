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
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../../../../../helpers/git_gud_logger.dart';
import '../../modal/custom_form_field.dart';

class TextfieldSelectFolderPath extends StatefulWidget {
  const TextfieldSelectFolderPath(
      {Key? key,
      required this.isProjectPathValid,
      required this.label,
      required this.pathDirectoryController,
      this.errorMessage})
      : super(key: key);
  final bool isProjectPathValid;
  final String label;
  final TextEditingController pathDirectoryController;
  final String? errorMessage;

  @override
  State<TextfieldSelectFolderPath> createState() =>
      _TextfieldSelectFolderPathState();
}

class _TextfieldSelectFolderPathState extends State<TextfieldSelectFolderPath> {
  late Logger log;
  @override
  void initState() {
    super.initState();
    log = getLogger(runtimeType.toString());
  }

  Future<void> selectDirectory() async {
    final String? selectedDirectory = await getDirectoryPath();
    if (selectedDirectory == null) {
      log.t('No folder selected');
    } else {
      widget.pathDirectoryController.text = selectedDirectory.toString();
      log.t('Folder selected $selectedDirectory');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 40, top: 20),
      child: CustomTextFormField(
        readOnly: true,
        labelText: widget.label,
        inputIsValid: widget.isProjectPathValid,
        controller: widget.pathDirectoryController,
        onTap: selectDirectory,
        suffixIcon: IconButton(
          icon: const Icon(
            Icons.folder,
          ),
          onPressed: () {},
        ),
        errorText: widget.errorMessage,
      ),
    );
  }
}
