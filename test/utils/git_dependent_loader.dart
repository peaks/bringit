/*
 * Copyright (c) 2020 Peaks
 *
 * This file is part of Brin'Git
 *
 * Brin'Git is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * Brin'Git is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with Brin'Git.  If not, see <http://www.gnu.org/licenses/>.
 */
import 'package:flutter/material.dart';
import 'package:git_ihm/domain/git/git_proxy.dart';
import 'package:git_ihm/ui/common/utils_factory.dart';
import 'package:provider/provider.dart';

import '../domain/mock/git_proxy_mock.dart';
import '../domain/utils/file/tree/tree_data_file_loader_test.dart';

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
