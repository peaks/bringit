/*
 * Copyright (c) 2020 Peaks
 *
 * This file is part of GitGud
 *
 * GitGud is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * GitGud is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with GitGud.  If not, see <http://www.gnu.org/licenses/>.
 */
import 'dart:io';

import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';
import 'package:git_ihm/git_gud_theme.dart';
import 'package:git_ihm/screen/home_screen.dart';
import 'package:git_ihm/utils/utils_factory.dart';
import 'package:provider/provider.dart';

import 'data/git/git_factory.dart';
import 'data/git_proxy.dart';

Future<void> main() async {
  // added to run the app. Crash without it
  WidgetsFlutterBinding.ensureInitialized();
  // On changera si besoin. Déjà quand Mégane et toi allez lancer l'app sur votre ordi vous allez pouvoir comparer
  // avec git kraken et github desktop sur vos écrans. On pourra peut-être mettre des pixel en fonction de fourchette de résolutions
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    await DesktopWindow.setWindowSize(const Size(1024, 576));
    await DesktopWindow.setMinWindowSize(const Size(1024, 576));
  }
  final GitFactory f = GitFactory();
  final GitProxy git = await f.getGit();
  final MultiProvider myApp = MultiProvider(
    providers: <InheritedProvider<dynamic>>[
      ChangeNotifierProvider<GitProxy>(create: (BuildContext context) => git),
      Provider<UtilsFactory>(create: (_) => UtilsFactory())
    ],
    child: const MyApp(),
  );

  runApp(myApp);
}

class MyApp extends StatelessWidget {
  const MyApp();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Clever Git',
      theme: GitGudTheme().darkTheme,
      home: const HomeScreen(),
    );
  }
}
