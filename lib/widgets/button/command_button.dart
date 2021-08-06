import 'package:flutter/material.dart';

class CommandButton extends StatelessWidget {
  const CommandButton({required this.title, required this.onPressed});
  final String title;
  final GestureTapCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(32.0),
        child: RawMaterialButton(
          fillColor: Colors.green,
          splashColor: Colors.greenAccent,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              title,
              maxLines: 1,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
          ),
          onPressed: onPressed,
          shape: const StadiumBorder(),
        ));
  }
}
