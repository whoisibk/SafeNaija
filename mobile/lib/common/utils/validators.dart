class Validators {
  static final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+',
  );

  static final RegExp _upperCaseRegExp = RegExp('[A-Z]');
  static final RegExp _lowerCaseRegExp = RegExp('[a-z]');
  static final RegExp _digitRegExp = RegExp('[0-9]');
  static final RegExp _specialCharRegExp = RegExp(r'[!@#\$&*~-]');

  static bool isValidEmail(String email) {
    return _emailRegExp.hasMatch(email);
  }

  static bool hasMinLength(String password, int minLength) {
    return password.length >= minLength;
  }

  static bool hasUpperCase(String password) {
    return _upperCaseRegExp.hasMatch(password);
  }

  static bool hasLowerCase(String password) {
    return _lowerCaseRegExp.hasMatch(password);
  }

  static bool hasDigit(String password) {
    return _digitRegExp.hasMatch(password);
  }

  static bool hasSpecialChar(String password) {
    return _specialCharRegExp.hasMatch(password);
  }

  static bool isValidPassword(String password) {
    return hasMinLength(password, 8) &&
        hasUpperCase(password) &&
        hasLowerCase(password) &&
        hasDigit(password) &&
        hasSpecialChar(password);
  }
}
