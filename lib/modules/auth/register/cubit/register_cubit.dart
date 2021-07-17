import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/register_model.dart';
import 'package:shop_app/models/login/login_response_model.dart';
import 'package:shop_app/network/end_points.dart';
import 'package:shop_app/network/local/preference_utils.dart';
import 'package:shop_app/network/remote/login_api_service.dart';
import '../../../../constant.dart';
import '../cubit/register_states.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(BuildContext context) => BlocProvider.of(context);

  void userRegister({
    @required RegisterModel registerModel,
  }) async {
    emit(RegisterLoadingState());
    try {
      Response response = await LoginApiService.registerUser(
          path: REGISTER, data: registerModel.toMap(), lang: "en");
      LoginResponseModel model = LoginResponseModel.fromJson(response.data);

      if (model.status) {
        PreferenceUtils.setData(userTokenKey, model.data.token);
        emit(RegisterSuccessState(model));
      } else {
        emit(RegisterErrorState(model.message));
      }
    } catch (e) {
      print(e.toString());
      emit(RegisterErrorState("Error"));
    }
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(RegisterChangePasswordVisibilityState());
  }
}
