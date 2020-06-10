import 'package:flutter/material.dart';
import 'package:timetracker/widgets/buttons/custom_raised_button.dart';

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
          CustomRaisedButton(
            child: Text(
              'Sign in with Google',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15.0,
              ),
            ),
            borderRadios: 8.0,
//            buttonColor: Colors.blueAccent,
            onPressed: _signInWithGoogle,
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
