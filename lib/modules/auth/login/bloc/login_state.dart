import 'package:shop_app/models/login/login_response_model.dart';

abstract class LoginState {
  const LoginState();
}

class LoginInitialState extends LoginState {
  const LoginInitialState();
}

class LoginLoadingState extends LoginState {
  const LoginLoadingState();
}

class LoginSuccessState extends LoginState {
  final LoginResponseModel model;

  const LoginSuccessState(this.model);
}

class LoginErrorState extends LoginState {
  final String message;

  const LoginErrorState(this.message);
}

class LoginChangePasswordVisibilityState extends LoginState {
  const LoginChangePasswordVisibilityState();
}

class LoginEmailEmptyFormatState extends LoginState {}

class LoginEmailInvalidFormatState extends LoginState {}

class LoginEmailFormatCorrectState extends LoginState {}

class LoginPasswordEmptyFormatState extends LoginState {}

class LoginPasswordInvalidFormatState extends LoginState {}

class LoginPasswordFormatCorrectState extends LoginState {}

class LoginNavigationToRegisterScreenState extends LoginState {
  const LoginNavigationToRegisterScreenState();
}
