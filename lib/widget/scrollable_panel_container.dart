import 'package:flutter/material.dart';
import 'package:flutter_nord_theme/flutter_nord_theme.dart';

class ScrollablePanelContainer extends StatelessWidget {
  const ScrollablePanelContainer(
      {Key? key,
      required this.child,
      required this.title,
      this.flex = 1,
      this.backgroundColor})
      : super(key: key);
  final Widget child;
  final String title;
  final Color? backgroundColor;
  final int flex;
  @override
  Widget build(BuildContext context) {
    final ScrollController _scrollController = ScrollController();
    return Expanded(
      flex: flex,
      child: Container(
        padding: const EdgeInsets.all(8),
        color: backgroundColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Text(
              title.toUpperCase(),
              style: const TextStyle(
                  color: NordColors.$8, fontWeight: FontWeight.w500),
            ),
            const Divider(
              color: NordColors.$0,
              thickness: 1,
            ),
            Expanded(
              child: Scrollbar(
                controller: _scrollController,
                thumbVisibility: true,
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: child,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
