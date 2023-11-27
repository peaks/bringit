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
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:git_ihm/domain/git/git_proxy.dart';
import 'package:git_ihm/helpers/git_gud_logger.dart';
import 'package:git_ihm/ui/common/utils_factory.dart';
import 'package:git_ihm/ui/screens/home_screen.dart';
import 'package:git_ihm/ui/theme/bringit_theme.dart';
import 'package:logger/logger.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';

import 'domain/git/git_factory.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
Future<void> main() async {
  final Logger log = getLogger('Main');

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
    child: const BrinGit(),
  );
  // Obtenir la version et le nom du package de l'application
  final PackageInfo packageInfo = await PackageInfo.fromPlatform();

  // Vérifier l'état de la connexion réseau
  final ConnectivityResult connectivityResult =
      await Connectivity().checkConnectivity();
  final String connectionStatus = connectivityResult.name;

  // Logs au démarrage de l'application
  log.i('''

  ██████████                  ████                    ████
██▒▒▒▒▒▒▒▒████              ██▒▒████                ██▒▒████
██▒▒██████▒▒████    ██████  ████████  ██████████    ██▒▒████
██▒▒██████▒▒████  ██▒▒▒▒██████▒▒██████▒▒▒▒▒▒▒▒████  ████████
██▒▒▒▒▒▒▒▒████████▒▒██████████▒▒██████▒▒██████▒▒████  ██████
██▒▒██████▒▒██████▒▒█████   ██▒▒██████▒▒██████▒▒████
██▒▒██████▒▒██████▒▒████    ██▒▒██████▒▒██████▒▒████
██▒▒▒▒▒▒▒▒████████▒▒████    ██▒▒██████▒▒██████▒▒████
████████████████████████    ████████████████████████
  ████████████    ██████      ██████  ████    ██████

    ██████████    ████      ████
  ██▒▒▒▒▒▒▒▒██████▒▒████  ██▒▒████
██▒▒████████████████████  ██▒▒████            ████
██▒▒██████████████▒▒██████▒▒▒▒▒▒████        ██▒▒████
██▒▒████▒▒▒▒██████▒▒████████▒▒██████        ████▒▒████
██▒▒██████▒▒██████▒▒████  ██▒▒████            ████▒▒████
██▒▒██████▒▒██████▒▒████  ██▒▒████            ██▒▒██████  ██████████
████▒▒▒▒▒▒████████▒▒████  ████▒▒████        ██▒▒██████  ██▒▒▒▒▒▒▒▒████
  ██████████████████████    ████████        ████████    ██████████████
    ██████████    ██████      ██████          ████        ████████████
''');
  log.i('Application version: ${packageInfo.version}');
  log.i('Platform: ${Platform.operatingSystem}');
  log.i('OS: ${Platform.operatingSystemVersion}');
  log.i('Network connection status: $connectionStatus');

  runApp(myApp);
}

class BrinGit extends StatefulWidget {
  const BrinGit();

  @override
  State<BrinGit> createState() => _BrinGitState();
}

class _BrinGitState extends State<BrinGit> {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: BrinGitTheme().darkTheme,
        home: const HomeScreen());
  }
}
