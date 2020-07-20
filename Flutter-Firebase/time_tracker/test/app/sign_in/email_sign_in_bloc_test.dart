import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:timetracker/app/sign_in/email_sign_in_bloc.dart';
import 'package:timetracker/app/sign_in/email_sign_in_model.dart';

import '../../mocks.dart';

void main() {
  MockAuth mockAuth;
  EmailSignInBloc bloc;

  setUp(() {
    mockAuth = MockAuth();
    bloc = EmailSignInBloc(auth: mockAuth);
  });
  tearDown(() {
    bloc.dispose();
  });

  test(
      'On update email & password and submit, modelStream emits the correct events',
      () async {
    when(mockAuth.signInWithEmailAndPassword(
        email: anyNamed('email'),
        password: anyNamed(
          'password',
        ))).thenThrow(PlatformException(code: 'ERROR'));

    expect(
      bloc.modelStream,
      emitsInOrder([
        EmailSignInModel(),
        EmailSignInModel(email: 'email@mail.com'),
        EmailSignInModel(
          email: 'email@mail.com',
          password: 'password',
        ),
        EmailSignInModel(
          email: 'email@mail.com',
          password: 'password',
          submitted: true,
          isLoading: true,
        ),
        EmailSignInModel(
          email: 'email@mail.com',
          password: 'password',
          submitted: true,
          isLoading: false,
        ),
      ]),
    );

    bloc.updateEmail('email@mail.com');
    bloc.updatePassword('password');

    try {
      await bloc.submit();
    } catch (e) {}
  });
}
