import 'package:flutter/material.dart';
import 'screens/get_started.dart';
import 'screens/get_started_2.dart';
import 'screens/get_started_3.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Parking Finder',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => GetStartedView(),
        '/started2': (context) => GetStarted2View(),
        '/started3': (context) => GetStarted3View(),
        // '/login': (context) => LoginScreen(),
        // '/register': (context) => RegisterScreen(),
        // '/home': (context) => HomePage(),
      },
    );
  }
}
