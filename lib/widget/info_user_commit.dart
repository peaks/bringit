import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
          style: GoogleFonts.roboto(
            textStyle: Theme.of(context).textTheme.titleMedium,
          ),
        )),
        const SizedBox(
          width: 5,
        ),
        Container(
            child: Text(
          userEmail,
          style: GoogleFonts.roboto(
            textStyle: Theme.of(context).textTheme.titleMedium,
            decoration: TextDecoration.underline,
          ),
        )),
      ],
    );
  }
}
