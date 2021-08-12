import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import 'package:shop_app/models/register/register_response_model.dart';
import 'package:shop_app/models/register/register_model.dart';
import 'package:shop_app/modules/auth/register/bloc/register_repository.dart';
import 'package:shop_app/utils/validator.dart';

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
      yield* handelRegisterEvent(event.registerModel);
    } else if (event is RegisterNavigationToLoginScreenState) {
      yield const RegisterNavigationToLoginScreenState();
    } else if (event is ChangePasswordVisibilityEvent) {
      yield changePasswordVisibility();
    }
  }

  Stream<RegisterState> handelRegisterEvent(
      RegisterModel registerModel) async* {
    final RegisterState userNameState =
        validateUserName(registerModel.username);
    if (userNameState is RegisterUsernameFormatCorrectState) {
      final RegisterState emailState = validateEmail(registerModel.email);
      if (emailState is RegisterEmailFormatCorrectState) {
        final RegisterState passwordState =
            validateEmail(registerModel.password);
        if (passwordState is RegisterPasswordFormatCorrectState) {
          final RegisterState phoneState = validatePhone(registerModel.phone);
          if (phoneState is RegisterPhoneFormatCorrectState) {
            yield const RegisterLoadingState();
            yield await registerRepository
                .signUpWithEmailAndPassword(registerModel);
          } else {
            yield phoneState;
          }
        } else {
          yield passwordState;
        }
      } else {
        yield emailState;
      }
    } else {
      yield userNameState;
    }
  }

  RegisterState validateUserName(String userName) {
    RegisterState registerState;
    final ValidationState validateState = Validator.validateUserName(userName);
    if (validateState == ValidationState.Empty) {
      registerState = RegisterUsernameEmptyFormatState();
    } else if (validateState == ValidationState.Formatting) {
      registerState = RegisterUsernameInvalidFormatState();
    } else {
      registerState = RegisterUsernameFormatCorrectState();
    }
    return registerState;
  }

  RegisterState validateEmail(String email) {
    RegisterState registerState;
    final ValidationState validateState = Validator.validateEmail(email);

    if (validateState == ValidationState.Empty) {
      registerState = RegisterEmailEmptyFormatState();
    } else if (validateState == ValidationState.Formatting) {
      registerState = RegisterEmailInvalidFormatState();
    } else {
      registerState = RegisterEmailFormatCorrectState();
    }
    return registerState;
  }

  RegisterState validatePassword(String password) {
    RegisterState registerState;
    final ValidationState validateState = Validator.validatePassword(password);
    if (validateState == ValidationState.Empty) {
      registerState = RegisterPasswordEmptyFormatState();
    } else if (validateState == ValidationState.Formatting) {
      registerState = RegisterPasswordInvalidFormatState();
    } else {
      registerState = RegisterPasswordFormatCorrectState();
    }
    return registerState;
  }

  RegisterState validatePhone(String phone) {
    RegisterState registerState;
    final ValidationState validateState = Validator.validatePhone(phone);
    if (validateState == ValidationState.Empty) {
      registerState = RegisterPasswordEmptyFormatState();
    } else if (validateState == ValidationState.Formatting) {
      registerState = RegisterPasswordInvalidFormatState();
    } else {
      registerState = RegisterPasswordFormatCorrectState();
    }
    return registerState;
  }

  RegisterChangePasswordVisibilityState changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    return const RegisterChangePasswordVisibilityState();
  }
}
