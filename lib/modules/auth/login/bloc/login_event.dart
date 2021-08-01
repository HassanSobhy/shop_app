import 'package:shop_app/models/login/login_model.dart';

abstract class LoginEvent {
  const LoginEvent();
}

class UserLoginEvent extends LoginEvent {
  final LoginModel loginModel;

  const UserLoginEvent(this.loginModel);
}

class ChangePasswordVisibilityEvent extends LoginEvent {
  const ChangePasswordVisibilityEvent();
}
