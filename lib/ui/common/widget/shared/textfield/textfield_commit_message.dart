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
import 'package:git_ihm/ui/common/widget/modal/custom_form_field.dart';

class TextfieldCommitMessage extends StatefulWidget {
  const TextfieldCommitMessage(
      {Key? key,
      required this.isCommitMessageValid,
      required this.isCommitMessageNotYetModified,
      required this.onCommitMessageChanged,
      required this.commitMessageMessageError})
      : super(key: key);
  final bool isCommitMessageValid;

  final bool isCommitMessageNotYetModified;
  final Future<void> Function(String val) onCommitMessageChanged;
  final String commitMessageMessageError;

  @override
  State<TextfieldCommitMessage> createState() => _TextfieldCommitMessageState();
}

class _TextfieldCommitMessageState extends State<TextfieldCommitMessage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(),
      child: CustomTextFormField(
        maxLines: 10,
        minLines: 3,
        keyboardType: TextInputType.multiline,
        readOnly: false,
        errorText: widget.commitMessageMessageError,
        inputIsValid: widget.isCommitMessageValid,
        onChanged: (String? val) => widget.onCommitMessageChanged(val ?? ''),
      ),
    );
  }
}
