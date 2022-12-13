import 'package:flutter/material.dart';

class PanelContainer extends StatelessWidget {
  const PanelContainer({Key? key, required this.child, required this.title})
      : super(key: key);
  final Widget child;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Text(
            title.toUpperCase(),
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const Divider(
            color: Colors.white,
          ),
          child,
        ],
      ),
    );
  }
}
