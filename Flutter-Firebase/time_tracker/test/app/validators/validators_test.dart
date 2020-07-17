import 'package:flutter_test/flutter_test.dart';
import 'package:timetracker/app/validators/validators.dart';

void main() {
  group('isValid', () {
    test('non empty string', () {
      final validator = NonEmptyStringValidator();
      expect(validator.isValid('value'), true);
    });
    test('empty string', () {
      final validator = NonEmptyStringValidator();
      expect(validator.isValid(''), false);
    });
    test('null string', () {
      final validator = NonEmptyStringValidator();
      expect(validator.isValid(null), false);
    });
  });

  group('isNotValid', () {
    test('non empty string', () {
      final validator = NonEmptyStringValidator();
      expect(validator.isNotValid('value'), false);
    });
    test('empty string', () {
      final validator = NonEmptyStringValidator();
      expect(validator.isNotValid(''), true);
    });
    test('null string', () {
      final validator = NonEmptyStringValidator();
      expect(validator.isNotValid(null), true);
    });
  });
}
