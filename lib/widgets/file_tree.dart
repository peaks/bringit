import 'package:flutter/material.dart';

class FileTree extends StatelessWidget {
  const FileTree({required this.path});
  final String path;

  @override
  Widget build(BuildContext context) {
    return Text(
      'Files in $path',
      style: const TextStyle(fontSize: 16),
    );
  }
}
