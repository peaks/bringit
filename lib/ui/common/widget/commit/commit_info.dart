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

class CommitInfo extends StatelessWidget {
  const CommitInfo(
      {Key? key,
      required this.commitHash,
      required this.commitSubject,
      required this.commitBody})
      : super(key: key);

  final String commitHash;
  final String commitSubject;
  final String commitBody;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ExpansionTile(
        shape: InputBorder.none,
        tilePadding: EdgeInsets.zero,
        controlAffinity: ListTileControlAffinity.leading,
        iconColor: Theme.of(context).colorScheme.primary,
        textColor: Theme.of(context).colorScheme.primary,
        childrenPadding: const EdgeInsets.only(left: 38.0),
        title: Row(
          children: <Widget>[
            Text(
              commitHash,
              style: Theme.of(context).textTheme.displayMedium,
            ),
            const SizedBox(width: 5),
            Text(
              commitSubject,
              style: Theme.of(context).textTheme.bodyMedium,
            )
          ],
        ),
        children: <Widget>[
          ListTile(
              title: Container(
                  child: Text(
            commitBody,
            style: Theme.of(context).textTheme.bodyMedium,
          ))),
        ],
      ),
      alignment: Alignment.topLeft,
    );
  }
}
