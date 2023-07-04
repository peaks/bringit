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

class ModalHome extends StatelessWidget {
  const ModalHome(
      {Key? key,
      required this.title,
      required this.icon,
      required this.validationTitle,
      required this.onSubmit,
      required this.modalContent})
      : super(key: key);

  final String title;
  final IconData icon;
  final String validationTitle;
  final GestureTapCallback onSubmit;
  final Widget modalContent;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      titlePadding: const EdgeInsets.symmetric(horizontal: 10),
      title: Container(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(
                      icon,
                      size: 16,
                      color: Theme.of(context).secondaryHeaderColor,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(title,
                        style: Theme.of(context).textTheme.displayLarge),
                  ],
                ),
                IconButton(
                  icon: const Icon(
                    Icons.close,
                    size: 16,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ),
            const Divider(
              thickness: 1,
            )
          ],
        ),
      ),
      content: Container(
        child: modalContent,
        width: 800,
      ),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.all(14.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColorDark,
                      side: BorderSide(
                        color: Theme.of(context).primaryColorDark,
                      )),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Cancel',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColorDark,
                      side: BorderSide(
                        color: Theme.of(context).primaryColorDark,
                      )),
                  onPressed: () {
                    onSubmit();
                  },
                  child: Text(
                    validationTitle,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
