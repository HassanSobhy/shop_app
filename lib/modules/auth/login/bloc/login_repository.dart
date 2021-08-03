import 'package:dio/dio.dart';

import 'package:shop_app/constant.dart';
import 'package:shop_app/models/login/login_model.dart';
import 'package:shop_app/models/login/login_response_model.dart';
import 'package:shop_app/modules/auth/login/bloc/login_state.dart';
import 'package:shop_app/network/end_points.dart';
import 'package:shop_app/network/local/preference_utils.dart';
import 'package:shop_app/network/remote/login_api_service.dart';
import 'package:shop_app/utils/auth_exception_handler.dart';

abstract class BaseLoginRepository {
  Future<LoginState> signInWithEmailAndPassword(LoginModel loginModel);
}

class LoginRepository extends BaseLoginRepository {
  @override
  Future<LoginState> signInWithEmailAndPassword(LoginModel loginModel) async {
    LoginState _loginState;
    String _errorMessage;
    String _language = "en";
    try {
      Response response = await LoginApiService.signInWithEmailAndPassword(
        path: LOGIN,
        data: loginModel.toMap(),
        lang: _language,
      );
      LoginResponseModel model = LoginResponseModel.fromJson(response.data);
      if (model.status) {
        _loginState = LoginSuccessState(model);
        PreferenceUtils.setData(
            userTokenKey, model.loginResponseDataModel.token);
      } else {
        _errorMessage = model.message;
        _loginState = LoginErrorState(_errorMessage);
      }
    } on DioError catch (e) {
      _errorMessage = AuthExceptionHandler.handleException(e);
      _loginState = LoginErrorState(_errorMessage);
    }
    ;

    return _loginState;
  }
}
