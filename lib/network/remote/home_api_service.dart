import 'package:flutter/material.dart';

import 'package:dio/dio.dart';

import 'package:shop_app/network/end_points.dart';
import 'dio_helper.dart';

class HomeApiService {
  static Future<Response> getData({
    @required String path,
    Map<String, dynamic> query,
    String lang = 'en',
    String token,
  }) async {
    DioHelper.dio.options.headers = {
      'lang': lang,
      'Authorization': token ?? "",
    };
    return await DioHelper.dio.get(path, queryParameters: query ?? null);
  }

  static Future<Response> changeFavorites({
    @required String path,
    @required Map<String, int> data,
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

  static Future<Response> getFavorites({
    @required String path,
    String lang = 'en',
    String token,
  }) {
    DioHelper.dio.options.headers = {
      'lang': lang,
      'Authorization': token,
    };
    return DioHelper.dio.get(path);
  }

  static Future<Response> getProfile({
    @required String path,
    String lang = 'en',
    String token,
  }) {
    DioHelper.dio.options.headers = {
      'lang': lang,
      'Authorization': token,
    };
    return DioHelper.dio.get(path);
  }

  static Future<Response> updateProfile({
    @required String path,
    @required Map<String, dynamic> data,
    String lang = 'en',
    String token,
  }) {
    DioHelper.dio.options.headers = {
      'lang': lang,
      'Authorization': token,
    };
    return DioHelper.dio.put(path,data: data);
  }

  static Future<Response> searchData({
    @required String path,
    @required Map<String, dynamic> data,
    String lang = 'en',
    String token,
  }){
    DioHelper.dio.options.headers = {
      'lang': lang,
      'Authorization': token,
    };

    return DioHelper.dio.post(path,data: data);
  }
}
