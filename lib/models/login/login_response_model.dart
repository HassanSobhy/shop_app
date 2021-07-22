class LoginResponseModel {
  bool status;
  String message;
  UserData data;

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'] as bool;
    message = json['message'] as String;
    data = json['data'] != null
        ? UserData.fromJson(json['data'])
        : null;
  }
}

class UserData {
  int id;
  String name;
  String email;
  String phone;
  String image;
  int points;
  int credit;
  String token;

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int;
    name = json['name'] as String;
    email = json['email'] as String;
    phone = json['phone'] as String;
    image = json['image'] as String;
    points = json['points'] as int;
    credit = json['credit'] as int;
    token = json['token'] as String;
  }
}
