import 'package:flutter/material.dart';
import 'package:timetracker/app/sign_in/email_sign_in_form.dart';
import 'package:timetracker/services/auth.dart';

class EmailSignInPage extends StatelessWidget {
  final AuthBase auth;

  const EmailSignInPage({Key key, this.auth}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign in'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          child: EmailSignInForm(
            auth: auth,
          ),
        ),
      ),
      backgroundColor: Colors.grey[200],
    );
  }
}
