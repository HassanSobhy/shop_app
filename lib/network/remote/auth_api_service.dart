import 'package:flutter/foundation.dart';

import 'package:dio/dio.dart';
import 'package:shop_app/network/remote/dio_helper.dart';

class AuthApiService {
  static Future<Response> signInWithEmailAndPassword(
      {@required String path,
      @required Map<String, dynamic> data,
      @required String lang}) async {
    DioHelper.dio.options.headers = {
      'lang': lang,
    };
    return DioHelper.dio.post(path, data: data);
  }

  static Future<Response> signUpWithEmailAndPassword({
    @required String path,
    @required Map<String, dynamic> data,
    @required String lang,
  }) async {
    DioHelper.dio.options.headers = {
      'lang': lang,
    };
    return DioHelper.dio.post(path, data: data);
  }
}
