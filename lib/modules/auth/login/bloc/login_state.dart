

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

class LoginEmailAndPasswordValidationState extends LoginState{
  final String emailMessage;
  final String passwordMessage;
  const LoginEmailAndPasswordValidationState(this.emailMessage,this.passwordMessage);
}

