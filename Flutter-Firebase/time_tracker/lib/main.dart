import 'package:flutter/material.dart';
import 'package:timetracker/app/landing_page.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Time Tracker',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: LandingPage(),
    );
  }
}
