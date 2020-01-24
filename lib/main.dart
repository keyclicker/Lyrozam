import 'package:flutter/material.dart';
import 'homepage.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      home: HomePage()
    );
  }
}

void main() => runApp(App());