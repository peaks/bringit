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
import 'package:git_ihm/ui/common/widget/modal/custom_form_field.dart';

class TextfieldProjectName extends StatefulWidget {
  const TextfieldProjectName(
      {Key? key,
      required this.isProjectNameValid,
      required this.pathDirectoryController,
      required this.isProjectNameNotYetModified,
      required this.onProjectNameChanged,
      required this.projectNameMessageError})
      : super(key: key);
  final bool isProjectNameValid;
  final TextEditingController pathDirectoryController;
  final bool isProjectNameNotYetModified;
  final Future<void> Function(String val) onProjectNameChanged;
  final String projectNameMessageError;

  @override
  State<TextfieldProjectName> createState() => _TextfieldProjectNameState();
}

class _TextfieldProjectNameState extends State<TextfieldProjectName> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: CustomTextFormField(
          readOnly: false,
          labelText: Wording.modalCreateNewGitProjectProjectNameLabel,
          hintText: Wording.modalCreateNewGitProjectProjectNameHintText,
          errorText: widget.projectNameMessageError,
          inputIsValid: widget.isProjectNameValid,
          onChanged: (String? val) => widget.onProjectNameChanged(val ?? ''),
          suffixIcon: !widget.isProjectNameNotYetModified
              ? IconButton(
                  icon: widget.isProjectNameValid
                      ? Icon(
                          Icons.check_circle,
                          color: Theme.of(context).colorScheme.onPrimary,
                        )
                      : Icon(Icons.warning_amber,
                          color: Theme.of(context).colorScheme.onError),
                  onPressed: () {},
                )
              : null),
    );
  }
}
