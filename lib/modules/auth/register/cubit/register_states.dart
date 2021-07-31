import 'package:shop_app/models/register/register_response_model.dart';

abstract class RegisterStates{}

class RegisterInitialState extends RegisterStates{}

class RegisterLoadingState extends RegisterStates{}

class RegisterSuccessState extends RegisterStates{
  final RegisterResponseModel model;

  RegisterSuccessState(this.model);
}

class RegisterErrorState extends RegisterStates{
  final String message;

  RegisterErrorState(this.message);
}

class RegisterChangePasswordVisibilityState extends RegisterStates{}
