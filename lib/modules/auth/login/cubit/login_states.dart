import 'package:shop_app/models/response_model.dart';

abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginSuccessState extends LoginStates {
  final ResponseModel model;

  LoginSuccessState(this.model);
}

class LoginErrorState extends LoginStates {
  final String message;

  LoginErrorState(this.message);
}

class LoginChangePasswordVisibilityState extends LoginStates {}
