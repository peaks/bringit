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

class StatusFileListHeader extends StatelessWidget {
  const StatusFileListHeader(
      {super.key, required this.title, required this.icon});
  final String title;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Icon(
          icon,
          size: 16,
          color: BrinGitTheme.frostBlue3Color,
        ),
        const SizedBox(
          width: 5,
        ),
        Expanded(
          child: Container(
              width: 250,
              child: Text(title,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .apply(overflow: TextOverflow.ellipsis))),
        ),
      ],
    );
  }
}
