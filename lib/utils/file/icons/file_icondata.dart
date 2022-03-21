import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:git_ihm/utils/file/icons/data.dart';

/*
 * File IconData for Flutter, inspired from https://github.com/git-touch/file-icon
 */

IconData getIconDataForFile(String fileName) {
  String key = '.txt';

  if (iconSetMap.containsKey(fileName)) {
    key = fileName;
  } else {
    List<String> chunks = fileName.split('.').sublist(1);
    while (chunks.isNotEmpty) {
      final String chunk = '.' + chunks.join();
      if (iconSetMap.containsKey(chunk)) {
        key = chunk;
        break;
      }
      chunks = chunks.sublist(1);
    }
  }

  return IconData(
    iconSetMap[key]?.codePoint ?? 0,
    fontFamily: 'Seti',
  );
}
