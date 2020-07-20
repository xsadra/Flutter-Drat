import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timetracker/app/sign_in/email_sign_in_model.dart';
import 'package:timetracker/services/auth.dart';

class EmailSignInBloc {
  EmailSignInBloc({@required this.auth});

  final AuthBase auth;
  final _modelSubject = BehaviorSubject<EmailSignInModel>.seeded(EmailSignInModel());

  Stream<EmailSignInModel> get modelStream => _modelSubject.stream;
  EmailSignInModel get _model => _modelSubject.value;

  void dispose() {
    _modelSubject.close();
  }

  void toggleFormType() {
    final formType = _model.formType == EmailSignInFormType.SIGN_IN
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
    _modelSubject.value = _model.copyWith(
      email: email,
      password: password,
      formType: formType,
      isLoading: isLoading,
      submitted: submitted,
    );
  }

  Future<void> submit() async {
    updateWith(submitted: true, isLoading: true);
    try {
      if (_model.formType == EmailSignInFormType.SIGN_IN) {
        await auth.signInWithEmailAndPassword(
          email: _model.email,
          password: _model.password,
        );
      } else {
        await auth.createUserWithEmailAndPassword(
          email: _model.email,
          password: _model.password,
        );
      }
    } catch (e) {
      updateWith(isLoading: false);
      rethrow;
    }
  }
}
