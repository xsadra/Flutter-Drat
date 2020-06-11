import 'package:flutter/material.dart';
import 'package:timetracker/services/auth.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key, @required this.onSignOut, @required this.auth})
      : super(key: key);

  final VoidCallback onSignOut;
  final AuthBase auth;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        actions: [
          FlatButton(
            onPressed: _signOut,
            child: Text(
              'Logout',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _signOut() async {
    try {
      await auth.signOut();
      onSignOut();
    } catch (e) {
      print(e.toString());
    }
  }
}
