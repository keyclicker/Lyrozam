import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'homepage.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);

      return MaterialApp(
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.grey,
          accentColor: Colors.black,
        ),
        home: HomePage()
    );
  }
}

void main() => runApp(App());