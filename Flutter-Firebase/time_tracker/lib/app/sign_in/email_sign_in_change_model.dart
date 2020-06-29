import 'package:flutter/foundation.dart';
import 'package:timetracker/app/sign_in/email_sign_in_model.dart';
import 'package:timetracker/app/validators/validators.dart';
import 'package:timetracker/services/auth.dart';

class EmailSignInChangeModel with EmailAndPasswordValidator, ChangeNotifier {
  EmailSignInChangeModel({
    @required this.auth,
    this.email = '',
    this.password = '',
    this.formType = EmailSignInFormType.SIGN_IN,
    this.isLoading = false,
    this.submitted = false,
  });
final AuthBase auth;
  String email;
  String password;
  EmailSignInFormType formType;
  bool isLoading;
  bool submitted;

  Future<void> submit() async {
    updateWith(submitted: true, isLoading: true);
    try {
      if (formType == EmailSignInFormType.SIGN_IN) {
        await auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      } else {
        await auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
      }
    } catch (e) {
      updateWith(isLoading: false);
      rethrow;
    }
  }

  String get primaryButtonText {
    return formType == EmailSignInFormType.SIGN_IN
        ? 'Sign in '
        : 'Create an account';
  }

  String get linkButtonText {
    return formType == EmailSignInFormType.SIGN_IN
        ? 'Need an account? Register'
        : 'Have an account? Sign in';
  }

  bool get canSubmit {
    return !isLoading &&
        emailValidator.isValid(email) &&
        passwordValidator.isValid(password);
  }

  String get passwordErrorText {
    bool showErrorText = submitted && passwordValidator.isNotValid(password);
    return showErrorText ? invalidPasswordErrorText : null;
  }

  String get emailErrorText {
    bool showErrorText = submitted && emailValidator.isNotValid(email);
    return showErrorText ? invalidEmailErrorText : null;
  }

  void toggleFormType() {
    final formType = this.formType == EmailSignInFormType.SIGN_IN
        ? EmailSignInFormType.REGISTER
        : EmailSignInFormType.SIGN_IN;
    updateWith(
      email: '',
      password: '',
      formType: formType,
      isLoading: false,
      submitted: false,
    );
  }

  void updateEmail(String email) => updateWith(email: email);

  void updatePassword(String password) => updateWith(password: password);

  void updateWith({
    String email,
    String password,
    EmailSignInFormType formType,
    bool isLoading,
    bool submitted,
  }) {
    this.email = email ?? this.email;
    this.password = password ?? this.password;
    this.formType = formType ?? this.formType;
    this.isLoading = isLoading ?? this.isLoading;
    this.submitted = submitted ?? this.submitted;
    notifyListeners();
  }
}
