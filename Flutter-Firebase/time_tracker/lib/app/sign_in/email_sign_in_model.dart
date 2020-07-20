import 'package:timetracker/app/validators/validators.dart';

enum EmailSignInFormType { SIGN_IN, REGISTER }

class EmailSignInModel with EmailAndPasswordValidator {
  EmailSignInModel({
    this.email = '',
    this.password = '',
    this.formType = EmailSignInFormType.SIGN_IN,
    this.isLoading = false,
    this.submitted = false,
  });

  final String email;
  final String password;
  final EmailSignInFormType formType;
  final bool isLoading;
  final bool submitted;

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

  EmailSignInModel copyWith({
    String email,
    String password,
    EmailSignInFormType formType,
    bool isLoading,
    bool submitted,
  }) {
    return EmailSignInModel(
      email: email ?? this.email,
      password: password ?? this.password,
      formType: formType ?? this.formType,
      isLoading: isLoading ?? this.isLoading,
      submitted: submitted ?? this.submitted,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EmailSignInModel &&
          runtimeType == other.runtimeType &&
          email == other.email &&
          password == other.password &&
          formType == other.formType &&
          isLoading == other.isLoading &&
          submitted == other.submitted;

  @override
  int get hashCode =>
      email.hashCode ^
      password.hashCode ^
      formType.hashCode ^
      isLoading.hashCode ^
      submitted.hashCode;

  @override
  String toString() {
    return 'EmailSignInModel{email: $email, password: $password, formType: $formType, isLoading: $isLoading, submitted: $submitted}';
  }
}
