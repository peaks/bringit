import 'package:flutter/material.dart';
import 'package:git_ihm/data/git_proxy.dart';
import 'package:provider/provider.dart';

import 'mock/git_proxy_mock.dart';

class GitDependentLoader {
  GitProxy? gitProxy;

  ChangeNotifierProvider<GitProxy> loadAppWithWidget(Widget testedWidget) {
    return ChangeNotifierProvider<GitProxy>(
        create: (BuildContext context) => _initProxy(),
        child: MaterialApp(
            home: Material(
          child: testedWidget,
        )));
  }

  GitProxy _initProxy() {
    gitProxy ??= GitProxyMock();

    return gitProxy!;
  }
}
