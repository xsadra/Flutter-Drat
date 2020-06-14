abstract class StringValidator {
  bool isValid(String value);

  bool isNotValid(String value);
}

class NonEmptyStringValidator implements StringValidator {
  @override
  bool isValid(String value) {
    return value.trim().isNotEmpty;
  }

  @override
  bool isNotValid(String value) {
    return !isValid(value);
  }
}

class EmailAndPasswordValidator {
  final StringValidator emailValidator = NonEmptyStringValidator();
  final StringValidator passwordValidator = NonEmptyStringValidator();
  final String invalidEmailErrorText = 'Email can\'t be Empty!';
  final String invalidPasswordErrorText = 'Password can\'t be Empty!';
}
