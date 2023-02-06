import 'package:flutter/material.dart';
import 'package:flutter_nord_theme/flutter_nord_theme.dart';
import 'package:git_ihm/screen/main_screen.dart';
import 'package:git_ihm/utils/utils_factory.dart';
import 'package:provider/provider.dart';

import 'data/git/git_factory.dart';
import 'data/git_proxy.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final GitFactory f = GitFactory();
  final GitProxy git = await f.getGit();
  final MultiProvider myApp = MultiProvider(
    providers: <InheritedProvider<dynamic>>[ChangeNotifierProvider<GitProxy>(create: (BuildContext context) => git), Provider<UtilsFactory>(create: (_) => UtilsFactory())],
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
      theme: NordTheme.dark(),
      home: const MainScreen(),
    );
  }
}
