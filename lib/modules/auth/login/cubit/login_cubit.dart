import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/login_models.dart';
import 'package:shop_app/models/register/register_response_model.dart';
import 'package:shop_app/network/end_points.dart';
import 'package:shop_app/network/local/preference_utils.dart';
import 'package:shop_app/network/remote/login_api_service.dart';

import '../../../../constant.dart';
import '../cubit/login_states.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(BuildContext context) => BlocProvider.of(context);

  void userLogin({
  @required LoginModel loginModel,
  }) async {
    emit(LoginLoadingState());
    try{
      Response response= await LoginApiService.postData(path: LOGIN, data: loginModel.toMap());
      RegisterResponseModel model = RegisterResponseModel.fromJson(response.data);

      if(model.status){
        PreferenceUtils.setData(userTokenKey, model.data.token);
        emit(LoginSuccessState(model));
      } else {
        emit(LoginErrorState(model.message));
      }
    } catch(e){
      print(e.toString());
      emit(LoginErrorState("Error"));
    }

  }


  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility()
  {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined ;

    emit(LoginChangePasswordVisibilityState());
  }

}
