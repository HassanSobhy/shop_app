import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../remote/dio_helper.dart';

class AuthApiService {
  static Future<Response> postData({
    @required String path,
    @required Map<String, dynamic> data,
    Map<String, dynamic> query,
    String lang = 'en',
    String token,
  }) async {
    DioHelper.dio.options.headers = {
      'lang': lang,
      'Authorization': token,
    };
    return DioHelper.dio.post(path, data: data, queryParameters: query);
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
