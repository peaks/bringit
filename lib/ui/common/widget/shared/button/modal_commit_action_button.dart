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
import 'package:git_ihm/ui/theme/bringit_theme.dart';

class ModalCommitActionButton extends StatefulWidget {
  const ModalCommitActionButton(
      {super.key, required this.title, required this.onPressed});
  final String title;
  final GestureTapCallback onPressed;

  @override
  State<ModalCommitActionButton> createState() =>
      _ModalCommitActionButtonState();
}

class _ModalCommitActionButtonState extends State<ModalCommitActionButton> {
  Color hovercolor = BrinGitTheme.unknownColor;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
            backgroundColor: Theme.of(context).primaryColorDark,
            side: BorderSide(
              color: hovercolor,
            )),
        onPressed: () {
          widget.onPressed();
        },
        child: Text(
          widget.title,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      onHover: (_) {
        setState(() {
          hovercolor = BrinGitTheme.standardColor;
        });
      },
      onExit: (_) {
        setState(() {
          hovercolor = BrinGitTheme.unknownColor;
        });
      },
    );
  }
}
