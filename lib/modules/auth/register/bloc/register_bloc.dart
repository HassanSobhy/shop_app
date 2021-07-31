import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shop_app/models/register/register_model.dart';
import 'package:shop_app/models/register/register_response_model.dart';
import 'package:shop_app/modules/auth/register/bloc/register_repository.dart';
part 'register_event.dart';

part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final BaseRegisterRepository registerRepository;
  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  RegisterBloc(this.registerRepository) : super(const RegisterInitialState());

  static RegisterBloc get(BuildContext context) =>
      BlocProvider.of<RegisterBloc>(context);

  @override
  Stream<RegisterState> mapEventToState(
    RegisterEvent event,
  ) async* {
    if (event is UserRegisterEvent) {
      yield const RegisterLoadingState();
      yield await registerRepository
          .signUpWithEmailAndPassword(event.registerModel);
    } else if (event is RegisterNavigationToLoginScreenState) {
      yield const RegisterNavigationToLoginScreenState();
    } else if (event is ChangePasswordVisibilityEvent) {
      yield changePasswordVisibility();
    }
  }

  RegisterChangePasswordVisibilityState changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
    isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    return RegisterChangePasswordVisibilityState();
  }


}
