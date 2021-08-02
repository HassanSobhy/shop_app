import 'package:shop_app/utils/extensions/string_extensions.dart';

class Validator {
  static bool isEmail(String email) {
    const String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    var regExp = RegExp(pattern);

    return regExp.hasMatch(email.trim());
  }

  static ValidationState validateEmail(String email) {
    if (email.isNullOrEmpty) {
      return ValidationState.Empty;
    } else if (!isEmail(email)) {
      return ValidationState.Formatting;
    } else {
      return ValidationState.Valid;
    }
  }

  static ValidationState validatePassword(String password) {
    if (password.isNullOrEmpty) {
      return ValidationState.Empty;
    } else if (password.length < 8) {
      return ValidationState.Formatting;
    } else {
      return ValidationState.Valid;
    }
  }

  static ValidationState validationUserName(String name) {
    if (name.isNullOrEmpty) {
      return ValidationState.Empty;
    } else if (name.length < 3) {
      return ValidationState.Formatting;
    } else {
      return ValidationState.Valid;
    }
  }
}

// ignore: constant_identifier_names
enum ValidationState { Empty, Formatting, Valid }
