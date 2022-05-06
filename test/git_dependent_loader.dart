import 'package:flutter/material.dart';
import 'package:git_ihm/data/git_proxy.dart';
import 'package:provider/provider.dart';

import 'mock/git_proxy_mock.dart';

class GitDependentLoader {
  ChangeNotifierProvider<GitProxy> loadAppWithWidget(Widget testedWidget,
      [GitProxy? gitProxy]) {
    return ChangeNotifierProvider<GitProxy>(
        create: (BuildContext context) {
          return _initProxy(gitProxy);
        },
        child: MaterialApp(
            home: Material(
          child: testedWidget,
        )));
  }

  GitProxy _initProxy(GitProxy? gitProxy) {
    if (gitProxy == null) {
      return GitProxyMock();
    }

    return gitProxy;
  }
}
