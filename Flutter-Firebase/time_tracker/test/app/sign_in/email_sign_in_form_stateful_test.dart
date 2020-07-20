import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:timetracker/app/sign_in/email_sign_in_form_stateful.dart';
import 'package:timetracker/services/auth.dart';

class MockAuth extends Mock implements AuthBase {}

void main() {
  MockAuth mockAuth;

  setUp(() {
    mockAuth = MockAuth();
  });

  Future<void> pumpEmailSignInForm(WidgetTester tester,
      {VoidCallback onSignIn}) async {
    Widget widget = Provider<AuthBase>(
      create: (_) => mockAuth,
      child: MaterialApp(
        home: Scaffold(
          body: EmailSignInFormStateful(
            onSignIn: onSignIn,
          ),
        ),
      ),
    );
    await tester.pumpWidget(widget);
  }

  group('Sign in', () {
    testWidgets(
        'On empty email&password, signIn not called, user is not sign in',
            (WidgetTester tester) async {
          var signIn = false;
          await pumpEmailSignInForm(
            tester,
            onSignIn: () => signIn = true,
          );

          final signInButton = find.text('Sign in ');
          await tester.tap(signInButton);

          verifyNever(mockAuth.signInWithEmailAndPassword(
            email: anyNamed('email'),
            password: anyNamed('password'),
          ));
          expect(signIn, false);
        });

    testWidgets(
        'On entries valid email&password, signIn is called, user signed in',
            (WidgetTester tester) async {
          var signIn = false;
          await pumpEmailSignInForm(
            tester,
            onSignIn: () => signIn = true,
          );

          const email = 'email@mail.com';
          const Password = 'Password';

          final emailField = find.byKey(Key('email'));
          expect(emailField, findsOneWidget);
          await tester.enterText(emailField, email);

          final passwordField = find.byKey(Key('password'));
          expect(passwordField, findsOneWidget);
          await tester.enterText(passwordField, Password);

          await tester.pump();

          final signInButton = find.text('Sign in ');
          await tester.tap(signInButton);

          verify(mockAuth.signInWithEmailAndPassword(
            email: email,
            password: Password,
          )).called(1);
          expect(signIn, true);
        });
  });

  group('Register', () {
    testWidgets('On toggles registration mode', (WidgetTester tester) async {
      await pumpEmailSignInForm(tester);

      final registerButton = find.text('Need an account? Register');
      await tester.tap(registerButton);

      await tester.pump();

      final createAccountButton = find.text('Create an account');
      expect(createAccountButton, findsOneWidget);
    });

    testWidgets('On entries email&password, createUser is called',
            (WidgetTester tester) async {
          await pumpEmailSignInForm(tester);

          const email = 'email@mail.com';
          const Password = 'Password';

          final registerButton = find.text('Need an account? Register');
          await tester.tap(registerButton);

          await tester.pump();

          final emailField = find.byKey(Key('email'));
          expect(emailField, findsOneWidget);
          await tester.enterText(emailField, email);

          final passwordField = find.byKey(Key('password'));
          expect(passwordField, findsOneWidget);
          await tester.enterText(passwordField, Password);

          await tester.pump();

          final createAccountButton = find.text('Create an account');
          expect(createAccountButton, findsOneWidget);
          await tester.tap(createAccountButton);

          verify(mockAuth.createUserWithEmailAndPassword(
            email: email,
            password: Password,
          )).called(1);
        });
  });
}
