import 'package:dio/dio.dart';
import 'package:shop_app/constant.dart';
import 'package:shop_app/models/register/register_model.dart';
import 'package:shop_app/models/register/register_response_model.dart';
import 'package:shop_app/modules/auth/register/bloc/register_bloc.dart';
import 'package:shop_app/network/end_points.dart';
import 'package:shop_app/network/local/preference_utils.dart';
import 'package:shop_app/network/remote/auth_api_service.dart';
import 'package:shop_app/utils/auth_exception_handler.dart';

abstract class BaseRegisterRepository {
  Future<RegisterState> signUpWithEmailAndPassword(RegisterModel registerModel);
}

class RegisterRepository extends BaseRegisterRepository {
  @override
  Future<RegisterState> signUpWithEmailAndPassword(
      RegisterModel registerModel) async {
    RegisterState _registerState;
    String _errorMessage;
    const String _language = "en";
    try {
      final Response response = await AuthApiService.signUpWithEmailAndPassword(
        path: REGISTER,
        data: registerModel.toMap(),
        lang: _language,
      );
      final RegisterResponseModel model =
          RegisterResponseModel.fromJson(response.data);
      if (model.status) {
        _registerState = RegisterSuccessState(model);
        PreferenceUtils.setData(
            userTokenKey, model.registerUserDataModel.token);
      } else {
        _errorMessage = model.message;
        _registerState = RegisterErrorState(_errorMessage);
      }
    } on DioError catch (e) {
      _errorMessage = AuthExceptionHandler.handleException(e);
      _registerState = RegisterErrorState(_errorMessage);
    }

    return _registerState;
  }
}
