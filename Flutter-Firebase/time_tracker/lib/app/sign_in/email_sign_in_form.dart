import 'package:flutter/material.dart';
import 'package:timetracker/widgets/buttons/form_submit_button.dart';

class EmailSignInForm extends StatelessWidget {
  List<Widget> _buildChildren() {
    return [
      TextField(
        decoration:
            InputDecoration(labelText: 'Email', hintText: 'you@email.com'),
      ),
      SizedBox(
        height: 12.0,
      ),
      TextField(
        decoration:
            InputDecoration(labelText: 'Password', hintText: '********'),
        obscureText: true,
      ),
      SizedBox(
        height: 12.0,
      ),
      FormSubmitButton(
        text: 'Sign in',
        onPressed: () {},
      ),
      FlatButton(
        onPressed: () {},
        child: Text('Need an account? Register'),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _buildChildren(),
      ),
    );
  }
}
