import 'package:dio/dio.dart';
import 'package:shop_app/constant.dart';
import 'package:shop_app/models/categories/categories.dart';
import 'package:shop_app/modules/categories/bloc/categories_bloc.dart';
import 'package:shop_app/network/end_points.dart';
import 'package:shop_app/network/local/preference_utils.dart';
import 'package:shop_app/network/remote/home_api_service.dart';
import 'package:shop_app/utils/auth_exception_handler.dart';

abstract class BaseCategoriesRepository {
  Future<CategoriesState> getCategoriesDate(String language);
}

class CategoriesRepository implements BaseCategoriesRepository {
  @override
  Future<CategoriesState> getCategoriesDate(String language) async {
    Categories _categories;
    CategoriesState _categoriesState;
    String _errorMessage;
    try {
      final Response response = await HomeApiService.getData(
        path: CATEGORIES,
        token: PreferenceUtils.getData(userTokenKey),
        lang: language,
      );
      _categories = Categories.fromJson(response.data);
      if (_categories.status) {
        _categoriesState = CategoriesSuccessState(_categories);
      } else {
        _errorMessage = "Something wrong happened";
        _categoriesState = CategoriesErrorState(_errorMessage);
      }
    } on DioError catch (e) {
      _errorMessage = AuthExceptionHandler.handleException(e);
      _categoriesState = CategoriesErrorState(_errorMessage);
    }

    return _categoriesState;
  }
}
