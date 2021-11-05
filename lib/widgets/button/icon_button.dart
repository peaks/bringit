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
