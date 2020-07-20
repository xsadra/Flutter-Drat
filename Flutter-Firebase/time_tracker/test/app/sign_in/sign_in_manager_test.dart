import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:timetracker/app/sign_in/sign_in_manager.dart';
import 'package:timetracker/services/auth.dart';

import '../../mocks.dart';

class MockValueNotifier<T> extends ValueNotifier<T> {
  MockValueNotifier(T value) : super(value);

  List<T> values = [];

  @override
  set value(T newValue) {
    values.add(newValue);
    super.value = newValue;
  }
}

void main() {
  MockAuth mockAuth;
  MockValueNotifier<bool> isLoading;
  SignInManager manager;

  setUp(() {
    mockAuth = MockAuth();
    isLoading = MockValueNotifier<bool>(false);
    manager = SignInManager(auth: mockAuth, isLoading: isLoading);
  });

  test('sign-in Success', () async {
    when(mockAuth.signInAnonymously()).thenAnswer(
      (_) => Future.value(
        User(
          uid: 'uid-123',
          photoUrl: null,
          displayName: null,
          email: null,
          phoneNumber: null,
        ),
      ),
    );

    await manager.signInAnonymously();

    expect(isLoading.values, [true]);
  });
}
