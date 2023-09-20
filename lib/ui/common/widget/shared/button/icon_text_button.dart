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
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:git_ihm/ui/theme/bringit_theme.dart';

class IconTextButton extends StatefulWidget {
  const IconTextButton({
    Key? key,
    required this.title,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final GestureTapCallback onPressed;

  @override
  State<IconTextButton> createState() => _IconTextButtonState();
}

class _IconTextButtonState extends State<IconTextButton> {
  Color hovercolor = BrinGitTheme.unknownColor;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          foregroundColor: Theme.of(context).colorScheme.primary,
          backgroundColor: BrinGitTheme.unknownColor,
          side: BorderSide(
            color: hovercolor,
          ),
        ),
        onPressed: widget.onPressed,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(widget.title),
            const SizedBox(
              width: 5,
            ),
            Icon(
              widget.icon,
              size: 16,
            ),
          ],
        ),
      ),
      onHover: (PointerHoverEvent s) {
        setState(() {
          hovercolor = Theme.of(context).colorScheme.primary;
        });
      },
      onExit: (PointerExitEvent s) {
        setState(() {
          hovercolor = BrinGitTheme.unknownColor;
        });
      },
    );
  }
}
