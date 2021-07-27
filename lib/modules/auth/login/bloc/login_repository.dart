import 'package:dio/dio.dart';

import 'package:shop_app/constant.dart';
import 'package:shop_app/models/login/login_model.dart';
import 'package:shop_app/models/login/login_response_model.dart';
import 'package:shop_app/modules/auth/login/bloc/login_state.dart';
import 'package:shop_app/network/end_points.dart';
import 'package:shop_app/network/local/preference_utils.dart';
import 'package:shop_app/network/remote/login_api_service.dart';

abstract class BaseLoginRepository {
  Future<LoginState> signInWithEmailAndPassword(LoginModel loginModel);
}

class LoginRepository extends BaseLoginRepository {
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
      if (model.status) {
        loginState = LoginSuccessState(model);
        PreferenceUtils.setData(
            userTokenKey, model.loginResponseDataModel.token);
      } else {
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
