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
