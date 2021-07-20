import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/models/login/login_model.dart';
import 'package:shop_app/models/login/login_response_model.dart';
import 'package:shop_app/modules/auth/login/bloc/login_state.dart';
import 'package:shop_app/network/remote/dio_helper.dart';
import 'package:shop_app/network/remote/login_api_service.dart';

import '../end_points.dart';

abstract class LoginRepository {
  Future<LoginState> signInWithEmailAndPassword(LoginModel loginModel);
}

class LoginRepositoryImp extends LoginRepository {
  @override
  Future<LoginState> signInWithEmailAndPassword(LoginModel loginModel) async {
    LoginState loginState;
    String errorMessage;
    String language = "en";
    try {
      Response response = await LoginApiService.signInWithEmailAndPassword(
        path: LOGIN,
        data: loginModel.toMap(),
        lang: language,
      );
      LoginResponseModel model = LoginResponseModel.fromJson(response.data);
      if(model.status){
        loginState = LoginSuccessState(model);
      } else{
        errorMessage = model.message;
        loginState = LoginErrorState(errorMessage);
      }
    } catch (e) {
      errorMessage = e.toString();
      loginState = LoginErrorState(errorMessage);
    }

    return loginState;
  }
}
