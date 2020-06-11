import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:timetracker/app/sign_in/sign_in_page.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  FirebaseUser _user;

  @override
  Widget build(BuildContext context) {
    return _user == null ? SignInPage(onSignIn: _updateUser,) : Container();
  }

  void _updateUser(FirebaseUser user) {
    setState(() {
      _user = user;
    });
  }
}
