import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
              child: Column(children: [
            const Text(
              'It\'s Git Time!',
              style: TextStyle(fontSize: 64, fontWeight: FontWeight.bold),
            ),
          ]))),
    );
  }
}
