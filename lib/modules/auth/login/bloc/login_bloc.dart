import 'package:flutter/material.dart';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/login/login_model.dart';

import 'package:shop_app/modules/auth/login/bloc/login_repository.dart';
import 'package:shop_app/utils/validator.dart';
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
    final LoginState emailState = validateEmail(loginModel.email);
    if (emailState is LoginEmailFormatCorrectState) {
      final LoginState passwordState = validatePassword(loginModel.password);
      if (passwordState is LoginEmailFormatCorrectState) {
        yield const LoginLoadingState();
        yield await loginRepository.signInWithEmailAndPassword(loginModel);
      } else {
        yield passwordState;
      }
    } else {
      yield emailState;
    }
  }

  LoginState validateEmail(String email) {
    LoginState loginState;
    final ValidationState validateState = Validator.validateEmail(email);

    if (validateState == ValidationState.Empty) {
      loginState = LoginEmailEmptyFormatState();
    } else if (validateState == ValidationState.Formatting) {
      loginState = LoginEmailInvalidFormatState();
    } else {
      loginState = LoginEmailFormatCorrectState();
    }
    return loginState;
  }

  LoginState validatePassword(String password) {
    LoginState loginState;
    final ValidationState validateState = Validator.validatePassword(password);
    if (validateState == ValidationState.Empty) {
      loginState = LoginPasswordEmptyFormatState();
    } else if (validateState == ValidationState.Formatting) {
      loginState = LoginPasswordInvalidFormatState();
    } else {
      loginState = LoginPasswordFormatCorrectState();
    }
    return loginState;
  }

  LoginChangePasswordVisibilityState changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    return LoginChangePasswordVisibilityState();
  }
}
