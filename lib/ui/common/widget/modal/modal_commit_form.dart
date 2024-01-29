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
import 'package:git_ihm/ui/common/widget/shared/textfield/textfield_commit_message.dart';

class ModalCommitForm extends StatefulWidget {
  const ModalCommitForm({Key? key}) : super(key: key);

  @override
  State<ModalCommitForm> createState() => _ModalCommitFormState();
}

class _ModalCommitFormState extends State<ModalCommitForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isAmendLastCommitChecked = false;
  late String commitMessageMessageError = '';
  bool isCommitMessageValid = true;
  bool isCommitMessageNotYetModified = true;

  Future<void> onCommitMessageChanged(String? val) async {
    commitMessageMessageError = '';
    isCommitMessageNotYetModified = false;

    if (val!.isEmpty) {
      commitMessageMessageError =
          Wording.modalCommitErrorMessageForEmptyCommitMessage;
      isCommitMessageValid = false;
    } else {
      isCommitMessageValid = true;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          const SizedBox(
            height: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                Wording.modalCommitMessageHintext,
                style: Theme.of(context).primaryTextTheme.titleLarge,
              ),
              const SizedBox(
                height: 5,
              ),
              TextfieldCommitMessage(
                isCommitMessageValid: isCommitMessageValid,
                isCommitMessageNotYetModified: isCommitMessageNotYetModified,
                onCommitMessageChanged: onCommitMessageChanged,
                commitMessageMessageError: commitMessageMessageError,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
