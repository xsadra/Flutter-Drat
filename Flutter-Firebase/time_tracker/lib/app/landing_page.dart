import 'package:flutter/material.dart';
import 'package:timetracker/app/home_page.dart';
import 'package:timetracker/app/sign_in/sign_in_page.dart';
import 'package:timetracker/services/auth.dart';

class LandingPage extends StatelessWidget {
  final AuthBase auth;

  const LandingPage({Key key, @required this.auth}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
        stream: auth.onAuthStateChanged,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            User user = snapshot.data;
            return user == null
                ? SignInPage(
                    auth: auth,
                  )
                : HomePage(
                    auth: auth,
                  );
          }
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}
