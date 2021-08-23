import 'package:dio/dio.dart';

import 'package:shop_app/constant.dart';
import 'package:shop_app/models/favorites/favorite_response_model.dart';
import 'package:shop_app/models/products/products.dart';
import 'package:shop_app/modules/products/bloc/products_bloc.dart';
import 'package:shop_app/network/end_points.dart';
import 'package:shop_app/network/local/preference_utils.dart';
import 'package:shop_app/network/remote/home_api_service.dart';
import 'package:shop_app/utils/auth_exception_handler.dart';

abstract class BaseProductsRepository {
  Future<ProductsState> getProductsData(String language);

  Future<ProductsState> setProductFavorite(
    Map<String, int> favorite,
    String language,
  );

  Map<int, bool> getFavoriteProducts();
}

class ProductsRepository implements BaseProductsRepository {
  Map<int, bool> favoriteProducts = {};

  @override
  Future<ProductsState> getProductsData(String language) async {
    Products _products;
    ProductsState _productsState;
    String _errorMessage;
    try {
      final Response response = await HomeApiService.getData(
        path: PRODUCTS,
        token: PreferenceUtils.getData(userTokenKey),
        lang: language,
      );
      _products = Products.fromJson(response.data);
      if (_products.status) {
        for (final element in _products.productsData.products) {
          favoriteProducts[element.id] = element.inFavorites;
        }
        _productsState = ProductsSuccessState(_products);
      } else {
        _errorMessage = "Something wrong happened";
        _productsState = ProductsErrorState(_errorMessage);
      }
    } on DioError catch (e) {
      _errorMessage = AuthExceptionHandler.handleException(e);
      _productsState = ProductsErrorState(_errorMessage);
    }

    return _productsState;
  }

  @override
  Future<ProductsState> setProductFavorite(
      Map<String, int> favorite, String language) async {
    ProductsState _productsState;
    String _errorMessage;
    try {
      favoriteProducts[favorite["product_id"]] =
          !favoriteProducts[favorite["product_id"]];
      final Response response = await HomeApiService.changeFavorites(
        path: FAVORITES,
        data: favorite,
        lang: language,
        token: PreferenceUtils.getData(userTokenKey),
      );
      final FavoriteResponseModel favoriteResponseModel =
          FavoriteResponseModel.fromJson(response.data);
      if (!favoriteResponseModel.status) {
        favoriteProducts[favorite["product_id"]] =
            !favoriteProducts[favorite["product_id"]];
        _errorMessage = "Something Went Wrong";
        _productsState = ProductsChangeFavoritesErrorState(_errorMessage);
      } else {
        _productsState =
            ProductsChangeFavoritesSuccessState(favoriteResponseModel.message);
      }
    } catch (e) {
      _errorMessage = e.toString();
      _productsState = ProductsChangeFavoritesErrorState(_errorMessage);
    }
    return _productsState;
  }

  @override
  Map<int, bool> getFavoriteProducts() {
    return favoriteProducts;
  }
}
