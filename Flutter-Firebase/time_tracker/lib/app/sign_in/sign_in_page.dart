import 'package:flutter/material.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Time Tracker'),
      ),
      body: _buildContent(),
      backgroundColor: Colors.grey[200],
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: EdgeInsets.all(32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Sign in',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 8.0,
          ),
          RaisedButton(
            onPressed: _signInWithGoogle,
            child: Text(
              'Sign in with Google',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15.0,
              ),
            ),
            color: Colors.blueAccent,
            padding: EdgeInsets.all(12.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0)
            ),
          ),
        ],
      ),
    );
  }

  void _signInWithGoogle() {
    //TODO: Auth with Google
    print('Auth with Google');
  }
}
