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

class RegisterFormValidationState extends RegisterState {
  final String userNameMessage;
  final String emailMessage;
  final String passwordMessage;
  final String phoneMessage;

  const RegisterFormValidationState(
    this.userNameMessage,
    this.emailMessage,
    this.passwordMessage,
    this.phoneMessage,
  );
}
