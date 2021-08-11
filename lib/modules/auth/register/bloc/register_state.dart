part of 'register_bloc.dart';

@immutable
abstract class RegisterState {
  const RegisterState();
}

class RegisterInitialState extends RegisterState {
  const RegisterInitialState();
}

class RegisterLoadingState extends RegisterState {
  const RegisterLoadingState();
}

class RegisterSuccessState extends RegisterState {
  final RegisterResponseModel model;

  const RegisterSuccessState(this.model);
}

class RegisterErrorState extends RegisterState {
  final String message;

  const RegisterErrorState(this.message);
}

class RegisterChangePasswordVisibilityState extends RegisterState {
  const RegisterChangePasswordVisibilityState();
}

class RegisterNavigationToLoginScreenState extends RegisterState {
  const RegisterNavigationToLoginScreenState();
}

class RegisterUsernameEmptyFormatState extends RegisterState {}

class RegisterUsernameInvalidFormatState extends RegisterState {}

class RegisterUsernameFormatCorrectState extends RegisterState {}

class RegisterEmailEmptyFormatState extends RegisterState {}

class RegisterEmailInvalidFormatState extends RegisterState {}

class RegisterEmailFormatCorrectState extends RegisterState {}

class RegisterPasswordEmptyFormatState extends RegisterState {}

class RegisterPasswordInvalidFormatState extends RegisterState {}

class RegisterPasswordFormatCorrectState extends RegisterState {}

class RegisterPhoneEmptyFormatState extends RegisterState {}

class RegisterPhoneInvalidFormatState extends RegisterState {}

class RegisterPhoneFormatCorrectState extends RegisterState {}
