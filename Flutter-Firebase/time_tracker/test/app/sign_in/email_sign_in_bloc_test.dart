import 'package:flutter_test/flutter_test.dart';
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
        expect(bloc.modelStream, emits(EmailSignInModel()));
      });
}
