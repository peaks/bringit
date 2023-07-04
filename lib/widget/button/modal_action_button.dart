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

class ModalActionButton extends StatelessWidget {
  const ModalActionButton(
      {Key? key,
      this.enable = true,
      required this.onSubmit,
      required this.title})
      : super(key: key);

  final bool enable;
  final GestureTapCallback onSubmit;
  final String title;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: enable
          ? OutlinedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColorDark,
              side: BorderSide(
                color: Theme.of(context).primaryColorDark,
              ))
          : OutlinedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.surface,
              side: BorderSide(
                color: Theme.of(context).colorScheme.surface,
              )),
      onPressed: enable ? onSubmit : null,
      child: Text(
        title,
        style: enable
            ? Theme.of(context).textTheme.titleMedium
            : Theme.of(context).textTheme.labelSmall,
      ),
    );
  }
}
