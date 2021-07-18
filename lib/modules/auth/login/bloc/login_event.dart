import 'package:shop_app/models/login/login_model.dart';

abstract class LoginEvent{}

class UserLoginEvent extends LoginEvent{
  LoginModel loginModel;

  UserLoginEvent(this.loginModel);
}