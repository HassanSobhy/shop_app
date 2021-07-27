import 'package:flutter/material.dart';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      yield LoginLoadingState();
      yield await loginRepository.signInWithEmailAndPassword(event.loginModel);
    } else if (event is ChangePasswordVisibilityEvent) {
      yield changePasswordVisibility();
    }
  }

  LoginChangePasswordVisibilityState changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    return LoginChangePasswordVisibilityState();
  }
}
