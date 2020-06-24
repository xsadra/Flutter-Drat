enum EmailSignInFormType { SIGN_IN, REGISTER }

class EmailSignInModel {
  EmailSignInModel({
    this.email = '',
    this.password = '',
    this.formType = EmailSignInFormType.SIGN_IN,
    this.isLoading = false,
    this.submited = false,
  });

  final String email;
  final String password;
  final EmailSignInFormType formType;
  final bool isLoading;
  final bool submited;
}
