class RegisterModel {
  final String username;
  final String email;
  final String password;
  final String phone;

  const RegisterModel({
    this.username,
    this.email,
    this.password,
    this.phone,
  });

  Map<String, String> toMap() {
    return {
      'name': username,
      "phone": phone,
      "email": email,
      "password": password,
    };
  }
}
