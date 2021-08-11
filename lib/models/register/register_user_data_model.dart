class RegisterUserDataModel {
  int id;
  String name;
  String email;
  String phone;
  String image;
  String token;

  RegisterUserDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    token = json['token'];
  }
}
