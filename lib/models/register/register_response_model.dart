import 'package:shop_app/models/register/register_user_data_model.dart';

class ResponseModel{
  bool status;
  String message;
  RegisterUserDataModel data;

  ResponseModel.fromJson(Map<String, dynamic> json)
  {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? RegisterUserDataModel.fromJson(json['data']) : null;
  }
}
