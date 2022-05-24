import 'package:flutter/material.dart';
import 'package:git_ihm/data/git_proxy.dart';
import 'package:git_ihm/utils/utils_factory.dart';
import 'package:provider/provider.dart';

import 'mock/git_proxy_mock.dart';
import 'utils/file/tree/tree_data_file_loader_test.dart';

class GitDependentLoader {
  GitProxy? gitProxy;
  UtilsFactory? utilsFactory;

  MultiProvider loadAppWithWidget(Widget testedWidget) {
    return MultiProvider(
        providers: <InheritedProvider<dynamic>>[
          ChangeNotifierProvider<GitProxy>(
              create: (BuildContext context) => _initProxy()),
          Provider<UtilsFactory>(
              create: (BuildContext context) => _initFactory()),
        ],
        child: MaterialApp(
            home: Material(
          child: testedWidget,
        )));
  }

  GitProxy _initProxy() {
    gitProxy ??= GitProxyMock();

    return gitProxy!;
  }

  UtilsFactory _initFactory() {
    utilsFactory ??= FakeUtilsFactory();

    return utilsFactory!;
  }
}
