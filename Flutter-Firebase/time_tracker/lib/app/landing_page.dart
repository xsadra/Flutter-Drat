import 'package:flutter/material.dart';
import 'package:timetracker/app/home_page.dart';
import 'package:timetracker/app/sign_in/sign_in_page.dart';
import 'package:timetracker/services/auth.dart';

class LandingPage extends StatefulWidget {
  final AuthBase auth;

  const LandingPage({Key key, @required this.auth}) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  User _user;

  @override
  Widget build(BuildContext context) {
    return _user == null
        ? SignInPage(
            auth: widget.auth,
            onSignIn: _updateUser,
          )
        : HomePage(
            auth: widget.auth,
            onSignOut: () => _updateUser(null),
          );
  }

  void _updateUser(User user) {
    setState(() {
      _user = user;
    });
  }

  @override
  void initState() {
    super.initState();
    _checkCurrentUser();
    widget.auth.onAuthStateChanged.listen((user) {
      print('User: ${user?.uid}');
    });
  }

  Future<void> _checkCurrentUser() async {
    User currentUser = await widget.auth.currentUser();
    _updateUser(currentUser);
  }
}
