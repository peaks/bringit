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
import 'package:flutter_gravatar/flutter_gravatar.dart';

class UserProfilePicture extends StatelessWidget {
  const UserProfilePicture({Key? key, required this.userEmail})
      : super(key: key);
  final String userEmail;

  @override
  Widget build(BuildContext context) {
    Image profile = Image.asset('assets/utilisateur.png');
    final Gravatar gravatar = Gravatar(userEmail);

    if (gravatar.imageUrl().isNotEmpty) {
      profile = Image.network(gravatar.imageUrl());
    }
    return Column(
      children: <Widget>[
        CircleAvatar(
          backgroundImage: profile.image,
          radius: 25,
        ),
      ],
    );
  }
}
