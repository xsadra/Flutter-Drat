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
}
