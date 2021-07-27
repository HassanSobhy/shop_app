class LoginModel {
  final String email;
  final String password;

  const LoginModel(
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
