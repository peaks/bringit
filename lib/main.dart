import 'package:flutter/material.dart';
import 'package:git_ihm/screen/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  final SharedPreferences sp = await SharedPreferences.getInstance();
  runApp(MyApp(sp));
}

class MyApp extends StatelessWidget {
  const MyApp(this.sharedPreferences);

  final SharedPreferences sharedPreferences;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clever Git',
      theme: ThemeData.dark(),
      home:
          HomeScreen(title: 'Clever Git', sharedPreferences: sharedPreferences),
    );
  }
}
