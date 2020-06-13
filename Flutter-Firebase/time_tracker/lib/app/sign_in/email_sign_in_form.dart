import 'package:flutter/material.dart';
import 'package:timetracker/widgets/buttons/form_submit_button.dart';

enum EmailSignInFormType { SIGN_IN, REGISTER }

class EmailSignInForm extends StatefulWidget {
  @override
  _EmailSignInFormState createState() => _EmailSignInFormState();
}

class _EmailSignInFormState extends State<EmailSignInForm> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  EmailSignInFormType _formType = EmailSignInFormType.SIGN_IN;

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

  List<Widget> _buildChildren() {
    final buttonText = _formType == EmailSignInFormType.SIGN_IN
        ? 'Sign in '
        : 'Create an account';
    final linkText = _formType == EmailSignInFormType.SIGN_IN
        ? 'Need an account? Register'
        : 'Have an account? Sign in';
    return [
      TextField(
        controller: _emailController,
        decoration:
            InputDecoration(labelText: 'Email', hintText: 'you@email.com'),
      ),
      SizedBox(
        height: 12.0,
      ),
      TextField(
        controller: _passwordController,
        decoration:
            InputDecoration(labelText: 'Password', hintText: '********'),
        obscureText: true,
      ),
      SizedBox(
        height: 12.0,
      ),
      FormSubmitButton(
        text: buttonText,
        onPressed: _submit,
      ),
      FlatButton(
        onPressed: _toggleFormType,
        child: Text(linkText),
      ),
    ];
  }

  void _toggleFormType() {
    setState(() {
      _formType = _formType == EmailSignInFormType.SIGN_IN
          ? EmailSignInFormType.REGISTER
          : EmailSignInFormType.SIGN_IN;
    });
    _emailController.clear();
    _passwordController.clear();
  }

  void _submit() {
    print(_emailController.text);
    print(_passwordController.text);
  }
}
