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
import 'package:git_ihm/ui/common/widget/modal/modal_commit_form.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ModalCommitContent extends StatefulWidget {
  const ModalCommitContent(
      {super.key,
      required this.userAuthor,
      required this.userEmail,
      required this.commitBranch});

  final String userAuthor;
  final String userEmail;
  final String commitBranch;

  @override
  State<ModalCommitContent> createState() => _ModalCommitContentState();
}

class _ModalCommitContentState extends State<ModalCommitContent> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(
                  MdiIcons.accountOutline,
                  color: Theme.of(context).colorScheme.primaryContainer,
                  size: 18,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(widget.userAuthor,
                    style: Theme.of(context).primaryTextTheme.titleSmall),
                const SizedBox(
                  width: 2,
                ),
                Text(
                  widget.userEmail,
                  style: Theme.of(context).primaryTextTheme.titleSmall,
                ),
              ],
            ),
            const SizedBox(
              width: 50,
            ),
            Row(
              children: <Widget>[
                Icon(
                  MdiIcons.sourceBranch,
                  color: Theme.of(context).colorScheme.primaryContainer,
                  size: 18,
                ),
                Text(
                  widget.commitBranch,
                  style: Theme.of(context).primaryTextTheme.titleSmall,
                ),
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: ModalCommitForm(),
        ),
      ],
    );
  }
}
