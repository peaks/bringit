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

class GIconButton extends StatelessWidget {
  const GIconButton({required this.icon, required this.onPressed});
  final IconData icon;
  final GestureTapCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: RawMaterialButton(
          fillColor: Colors.lightBlue,
          splashColor: Colors.lightBlueAccent,
          child: Padding(
              padding: const EdgeInsets.all(4.0), child: Icon(icon, size: 26)),
          onPressed: onPressed,
          shape: const StadiumBorder(),
        ));
  }
}
