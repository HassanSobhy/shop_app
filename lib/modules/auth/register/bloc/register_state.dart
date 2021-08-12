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

class RegisterUsernameEmptyFormatState extends RegisterState {
  final String message;

  const RegisterUsernameEmptyFormatState(this.message);
}

class RegisterUsernameInvalidFormatState extends RegisterState {
  final String message;

  const RegisterUsernameInvalidFormatState(this.message);
}

class RegisterUsernameFormatCorrectState extends RegisterState {}

class RegisterEmailEmptyFormatState extends RegisterState {
  final String message;

  const RegisterEmailEmptyFormatState(this.message);
}

class RegisterEmailInvalidFormatState extends RegisterState {
  final String message;

  const RegisterEmailInvalidFormatState(this.message);
}

class RegisterEmailFormatCorrectState extends RegisterState {}

class RegisterPasswordEmptyFormatState extends RegisterState {
  final String message;

  const RegisterPasswordEmptyFormatState(this.message);
}

class RegisterPasswordInvalidFormatState extends RegisterState {
  final String message;

  const RegisterPasswordInvalidFormatState(this.message);
}

class RegisterPasswordFormatCorrectState extends RegisterState {}

class RegisterPhoneEmptyFormatState extends RegisterState {
  final String message;

  const RegisterPhoneEmptyFormatState(this.message);
}

class RegisterPhoneInvalidFormatState extends RegisterState {
  final String message;

  const RegisterPhoneInvalidFormatState(this.message);
}

class RegisterPhoneFormatCorrectState extends RegisterState {}
