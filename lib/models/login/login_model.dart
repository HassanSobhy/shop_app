class LoginModel {
  String email;
  String password;

  LoginModel(
    this.email,
    this.password,
  );

  Map<String, String> toMap() {
    return {
      'email': email,
      "password": password,
    };
  }
}
