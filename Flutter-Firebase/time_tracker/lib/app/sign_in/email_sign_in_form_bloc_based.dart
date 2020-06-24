import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:timetracker/app/sign_in/email_sign_in_bloc.dart';
import 'package:timetracker/app/sign_in/email_sign_in_model.dart';
import 'package:timetracker/app/validators/validators.dart';
import 'package:timetracker/services/auth.dart';
import 'package:timetracker/widgets/buttons/form_submit_button.dart';
import 'package:timetracker/widgets/platform/platform_exception_alert_dialog.dart';

class EmailSignInFormBlocBased extends StatefulWidget
    with EmailAndPasswordValidator {
  EmailSignInFormBlocBased({@required this.bloc});

  final EmailSignInBloc bloc;

  static Widget create(BuildContext context) {
    final AuthBase auth = Provider.of<AuthBase>(context, listen: false);
    return Provider<EmailSignInBloc>(
      create: (context) => EmailSignInBloc(auth: auth),
      dispose: (context, bloc) => bloc.dispose(),
      child: Consumer<EmailSignInBloc>(
        builder: (context, bloc, _) => EmailSignInFormBlocBased(bloc: bloc),
      ),
    );
  }

  @override
  _EmailSignInFormBlocBasedState createState() =>
      _EmailSignInFormBlocBasedState();
}

class _EmailSignInFormBlocBasedState extends State<EmailSignInFormBlocBased> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<EmailSignInModel>(
        stream: widget.bloc.modelStream,
        initialData: EmailSignInModel(),
        builder: (context, snapshot) {
          final EmailSignInModel model = snapshot.data;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: _buildChildren(model: model),
            ),
          );
        });
  }

  List<Widget> _buildChildren({EmailSignInModel model}) {
    final buttonText = model.formType == EmailSignInFormType.SIGN_IN
        ? 'Sign in '
        : 'Create an account';
    final linkText = model.formType == EmailSignInFormType.SIGN_IN
        ? 'Need an account? Register'
        : 'Have an account? Sign in';

    bool isSubmitEnabled = !model.isLoading &&
        widget.emailValidator.isValid(model.email) &&
        widget.passwordValidator.isValid(model.password);
    return [
      _buildEmailTextField(model: model),
      SizedBox(
        height: 12.0,
      ),
      _buildPasswordTextField(model: model),
      SizedBox(
        height: 12.0,
      ),
      FormSubmitButton(
        text: buttonText,
        onPressed: isSubmitEnabled ? _submit : null,
      ),
      FlatButton(
        onPressed: model.isLoading ? null : _toggleFormType,
        child: Text(linkText),
      ),
    ];
  }

  TextField _buildPasswordTextField({EmailSignInModel model}) {
    bool showErrorText =
        model.submitted && widget.passwordValidator.isNotValid(model.password);
    return TextField(
      controller: _passwordController,
      focusNode: _passwordFocusNode,
      decoration: InputDecoration(
        labelText: 'Password',
        hintText: '********',
        enabled: !model.isLoading,
        errorText: showErrorText ? widget.invalidPasswordErrorText : null,
      ),
      obscureText: true,
      textInputAction: TextInputAction.done,
      onChanged: widget.bloc.updatePassword,
      onEditingComplete: _submit,
    );
  }

  TextField _buildEmailTextField({EmailSignInModel model}) {
    bool showErrorText =
        model.submitted && widget.emailValidator.isNotValid(model.email);
    return TextField(
      controller: _emailController,
      focusNode: _emailFocusNode,
      decoration: InputDecoration(
        labelText: 'Email',
        hintText: 'you@email.com',
        enabled: !model.isLoading,
        errorText: showErrorText ? widget.invalidEmailErrorText : null,
      ),
      autocorrect: false,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onChanged: widget.bloc.updateEmail,
      onEditingComplete: () => _emailEditingComplete(model: model),
    );
  }

  void _emailEditingComplete({EmailSignInModel model}) {
    final focusNode = widget.emailValidator.isValid(model.email)
        ? _passwordFocusNode
        : _emailFocusNode;
    FocusScope.of(context).requestFocus(focusNode);
  }

  void _toggleFormType() {
    widget.bloc.toggleFormType();
    _emailController.clear();
    _passwordController.clear();
  }

  void _submit() async {
    try {
      await widget.bloc.submit();
      Navigator.of(context).pop();
    } on PlatformException catch (e) {
      PlatformExceptionAlertDialog(
        title: 'Sign in failed',
        exception: e,
      ).show(context);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }
}
