/*
 * Copyright (c) 2020 Peaks
 *
 * This file is part of GitGud
 *
 * GitGud is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * GitGud is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with GitGud.  If not, see <http://www.gnu.org/licenses/>.
 */
import 'package:flutter/material.dart';

class InfoUserCommit extends StatelessWidget {
  const InfoUserCommit(
      {Key? key, required this.userAuthor, required this.userEmail})
      : super(key: key);
  final String userAuthor;
  final String userEmail;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
            child: Text(
          userAuthor,
          style: Theme.of(context).textTheme.titleMedium,
        )),
        const SizedBox(
          width: 5,
        ),
        Container(
            child: Text(
          userEmail,
          style: Theme.of(context).textTheme.displaySmall,
        )),
      ],
    );
  }
}
