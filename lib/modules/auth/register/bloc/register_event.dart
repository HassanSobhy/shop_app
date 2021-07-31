part of 'register_bloc.dart';

@immutable
abstract class RegisterEvent {
  const RegisterEvent();
}

class UserRegisterEvent extends RegisterEvent {
  final RegisterModel registerModel;

  const UserRegisterEvent(this.registerModel);
}

class ChangePasswordVisibilityEvent extends RegisterEvent {
  const ChangePasswordVisibilityEvent();
}

class NavigationToLoginScreenEvent extends RegisterEvent{
  const NavigationToLoginScreenEvent();
}
