import 'package:shop_app/models/login/login_response_data_model.dart';

class LoginResponseModel {
  bool status;
  String message;
  LoginResponseDataModel loginResponseDataModel;

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'] as bool;
    message = json['message'] as String;
    loginResponseDataModel = json['data'] != null
        ? LoginResponseDataModel.fromJson(json['data'])
        : null;
  }
}
