import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../remote/dio_helper.dart';

class LoginApiService {

  static Future<Response> signInWithEmailAndPassword(
      {@required String path,
      @required Map<String, dynamic> data,
      @required String lang}) async {
    DioHelper.dio.options.headers = {
      'lang': lang,
    };
    return DioHelper.dio.post(path, data: data);
  }


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

  static Future<Response> registerUser({
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
