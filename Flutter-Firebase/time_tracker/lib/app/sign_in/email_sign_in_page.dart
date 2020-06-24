import 'package:flutter/material.dart';
import 'package:timetracker/app/sign_in/email_sign_in_form_stateful.dart';

class EmailSignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign in'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          child: EmailSignInFormStateful(),
        ),
      ),
      backgroundColor: Colors.grey[200],
    );
  }
}
