import 'package:flutter/cupertino.dart';

class RegisterModel {
  final String username;
  final String email;
  final String password;
  final String phone;

  const RegisterModel({
    @required this.username,
    @required this.email,
    @required this.password,
    @required this.phone,
  });

  Map<String, String> toMap() {
    return {
      'name': email,
      "phone": phone,
      "email": email,
      "password": password,
    };
  }
}
