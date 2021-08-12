import 'package:shop_app/models/register/register_user_data_model.dart';

class RegisterResponseModel {
  bool status;
  String message;
  RegisterUserDataModel registerUserDataModel;

  RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    registerUserDataModel = json['data'] != null
        ? RegisterUserDataModel.fromJson(json['data'])
        : null;
  }
}
