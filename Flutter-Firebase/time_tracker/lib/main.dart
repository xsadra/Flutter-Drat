import 'package:flutter/material.dart';
import 'package:timetracker/app/landing_page.dart';
import 'package:timetracker/services/auth.dart';
import 'package:timetracker/services/auth_provider.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AuthProvider(
      auth: Auth(),
      child: MaterialApp(
        title: 'Time Tracker',
        theme: ThemeData(
          primarySwatch: Colors.brown,
        ),
        home: LandingPage(),
      ),
    );
  }
}
