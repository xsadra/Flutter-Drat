import 'package:flutter/material.dart';
import 'package:timetracker/app/sign_in/sign_in_page.dart';

void main(){
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Time Tracker',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: SignInPage(),
    );
  }
}
