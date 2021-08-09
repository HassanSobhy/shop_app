import 'package:flutter/material.dart';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/login/login_model.dart';

import 'package:shop_app/modules/auth/login/bloc/login_repository.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final BaseLoginRepository loginRepository;
  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  LoginBloc(this.loginRepository) : super(LoginInitialState());

  static LoginBloc get(BuildContext context) =>
      BlocProvider.of<LoginBloc>(context);

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is UserLoginEvent) {
      yield* handelLoginEvent(event.loginModel);
    } else if (event is ChangePasswordVisibilityEvent) {
      yield changePasswordVisibility();
    } else if (event is NavigationToRegisterScreenEvent) {
      yield const LoginNavigationToRegisterScreenState();
    }
  }

  Stream<LoginState> handelLoginEvent(LoginModel loginModel) async* {
    if (loginModel.email.isEmpty) {
      yield LoginEmailValidationState("Email Is Empty");
    } else {
      if (loginModel.password.isEmpty) {
        yield LoginPasswordValidationState("Password is Empty");
      } else {
        yield const LoginLoadingState();
        yield await loginRepository.signInWithEmailAndPassword(loginModel);
      }
    }
  }

  String isEmailIsEmpty(String email) {
    return email.isEmpty ? "Email can't be empty" : null;
  }

  String isPasswordIsEmpty(String password) {
    return password.isEmpty ? "Password can't be empty" : null;
  }

  LoginEmailAndPasswordValidationState validateEmailAndPassword(
      LoginModel model) {
    return LoginEmailAndPasswordValidationState(
      isEmailIsEmpty(model.email),
      isPasswordIsEmpty(model.password),
    );
  }

  LoginChangePasswordVisibilityState changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    return LoginChangePasswordVisibilityState();
  }
}
