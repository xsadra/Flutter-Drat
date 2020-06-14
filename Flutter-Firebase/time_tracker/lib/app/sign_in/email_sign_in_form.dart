import 'package:flutter/material.dart';
import 'package:timetracker/app/validators/validators.dart';
import 'package:timetracker/services/auth.dart';
import 'package:timetracker/widgets/buttons/form_submit_button.dart';

enum EmailSignInFormType { SIGN_IN, REGISTER }

class EmailSignInForm extends StatefulWidget with EmailAndPasswordValidator {
  final AuthBase auth;

  EmailSignInForm({Key key, @required this.auth}) : super(key: key);

  @override
  _EmailSignInFormState createState() => _EmailSignInFormState();
}

class _EmailSignInFormState extends State<EmailSignInForm> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  String get _email => _emailController.text;

  String get _password => _passwordController.text;

  EmailSignInFormType _formType = EmailSignInFormType.SIGN_IN;

  bool _submitted = false;
  bool _isLoading = false;

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

    bool isSubmitEnabled = !_isLoading &&
        widget.emailValidator.isValid(_email) &&
        widget.passwordValidator.isValid(_password);
    return [
      _buildEmailTextField(),
      SizedBox(
        height: 12.0,
      ),
      _buildPasswordTextField(),
      SizedBox(
        height: 12.0,
      ),
      FormSubmitButton(
        text: buttonText,
        onPressed: isSubmitEnabled ? _submit : null,
      ),
      FlatButton(
        onPressed: _isLoading ? null : _toggleFormType,
        child: Text(linkText),
      ),
    ];
  }

  TextField _buildPasswordTextField() {
    bool showErrorText =
        _submitted && widget.passwordValidator.isNotValid(_password);
    return TextField(
      controller: _passwordController,
      focusNode: _passwordFocusNode,
      decoration: InputDecoration(
        labelText: 'Password',
        hintText: '********',
        enabled: !_isLoading,
        errorText: showErrorText ? widget.invalidPasswordErrorText : null,
      ),
      obscureText: true,
      textInputAction: TextInputAction.done,
      onChanged: (password) => _updateState(),
      onEditingComplete: _submit,
    );
  }

  TextField _buildEmailTextField() {
    bool showErrorText = _submitted && widget.emailValidator.isNotValid(_email);
    return TextField(
      controller: _emailController,
      focusNode: _emailFocusNode,
      decoration: InputDecoration(
        labelText: 'Email',
        hintText: 'you@email.com',
        enabled: !_isLoading,
        errorText: showErrorText ? widget.invalidEmailErrorText : null,
      ),
      autocorrect: false,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onChanged: (email) => _updateState(),
      onEditingComplete: _emailEditingComplete,
    );
  }

  void _emailEditingComplete() {
    FocusScope.of(context).requestFocus(_passwordFocusNode);
  }

  void _toggleFormType() {
    setState(() {
      _submitted = false;
      _formType = _formType == EmailSignInFormType.SIGN_IN
          ? EmailSignInFormType.REGISTER
          : EmailSignInFormType.SIGN_IN;
    });
    _emailController.clear();
    _passwordController.clear();
  }

  void _submit() async {
    setState(() {
      _submitted = true;
      _isLoading = true;
    });
    try {
      if (_formType == EmailSignInFormType.SIGN_IN) {
        await widget.auth
            .signInWithEmailAndPassword(email: _email, password: _password);
      } else {
        await widget.auth
            .createUserWithEmailAndPassword(email: _email, password: _password);
      }
      Navigator.of(context).pop();
    } catch (e) {
      print(e.toString());
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _updateState() {
    setState(() {});
  }
}
