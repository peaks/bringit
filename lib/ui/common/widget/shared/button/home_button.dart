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

class HomeButton extends StatefulWidget {
  const HomeButton({
    Key? key,
    required this.title,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final GestureTapCallback onPressed;

  @override
  State<HomeButton> createState() => _HomeButtonState();
}

class _HomeButtonState extends State<HomeButton> {
  late bool isHover;

  @override
  void initState() {
    super.initState();
    isHover = false;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: MouseRegion(
        child: OutlinedButton(
          onHover: (bool value) {
            setState(() {
              isHover = true;
            });
          },
          style: OutlinedButton.styleFrom(
            foregroundColor: Theme.of(context).colorScheme.primary,
            backgroundColor: Theme.of(context).colorScheme.background,
            side: BorderSide(
              color: Theme.of(context).colorScheme.secondaryContainer,
              width: isHover == true ? 4 : 2,
            ),
            shadowColor: Theme.of(context).primaryColorDark,
            elevation: isHover == true ? 5 : 0,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
          ),
          onPressed: widget.onPressed,
          child: Container(
            width: 500,
            height: 125,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  width: isHover ? 5 : 10,
                ),
                Icon(
                  widget.icon,
                  size: isHover ? 100 : 90,
                  shadows: <Shadow>[
                    Shadow(
                        color: Theme.of(context).primaryColorDark,
                        blurRadius: 25)
                  ],
                  color: Theme.of(context).colorScheme.primaryContainer,
                ),
                SizedBox(
                  width: isHover ? 5 : 10,
                ),
                Text(
                  widget.title,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ],
            ),
          ),
        ),
        onExit: (PointerExitEvent s) {
          setState(() {
            isHover = false;
          });
        },
      ),
    );
  }
}
