import 'package:shop_app/models/response_model.dart';

abstract class RegisterStates{}

class RegisterInitialState extends RegisterStates{}

class RegisterLoadingState extends RegisterStates{}

class RegisterSuccessState extends RegisterStates{
  final ResponseModel model;

  RegisterSuccessState(this.model);
}

class RegisterErrorState extends RegisterStates{
  final String message;

  RegisterErrorState(this.message);
}

class RegisterChangePasswordVisibilityState extends RegisterStates{}
