import 'package:shop_app/utils/extensions/string_extensions.dart';

class Validator {
  static bool isEmail(String email) {
    const String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    final RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(email.trim());
  }

  static bool isPhone(String phone) {
    const String pattern = "^01[0-2]{1}[0-9]{8}";
    final RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(phone.trim());
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

  static ValidationState validateUserName(String name) {
    if (name.isNullOrEmpty) {
      return ValidationState.Empty;
    } else if (name.length < 3) {
      return ValidationState.Formatting;
    } else {
      return ValidationState.Valid;
    }
  }

  static ValidationState validatePhone(String phone) {
    if (phone.isNullOrEmpty) {
      return ValidationState.Empty;
    } else if (phone.length != 11 || !isPhone(phone)) {
      return ValidationState.Formatting;
    } else {
      return ValidationState.Valid;
    }
  }
}

// ignore: constant_identifier_names
enum ValidationState { Empty, Formatting, Valid }
