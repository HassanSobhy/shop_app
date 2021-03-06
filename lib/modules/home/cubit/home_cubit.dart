import 'package:flutter/material.dart';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shop_app/constant.dart';
import 'package:shop_app/models/categories/categories.dart';
import 'package:shop_app/models/favorites/favorite.dart';
import 'package:shop_app/models/favorites/favorite_response_model.dart';
import 'package:shop_app/models/products/products.dart';
import 'package:shop_app/models/login/login_response_model.dart';
import 'package:shop_app/modules/home/cubit/home_states.dart';
import 'package:shop_app/network/end_points.dart';
import 'package:shop_app/network/local/preference_utils.dart';
import 'package:shop_app/network/remote/home_api_service.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(BuildContext context) => BlocProvider.of(context);

  bool isGetCategories = false;
  bool isGetFavorites = false;
  bool isGetProfile = false;

  Products home;
  Categories categoriesModel;
  FavoriteResponseModel favoriteResponseModel;
  LoginResponseModel userDataModel;
  Favorites favorite;
  Map<int, bool> favorites = {};

  Future<void> getCategoryData() async {
    emit(HomeCategoryLoadingState());
    try {
      Response response = await HomeApiService.getData(path: CATEGORIES);
      categoriesModel = Categories.fromJson(response.data);
      if (categoriesModel.status) {
        isGetCategories = true;
        emit(HomeCategorySuccessState());
      } else {
        emit(HomeCategoryErrorState());
      }
    } catch (e) {
      emit(HomeCategoryErrorState());
    }
  }

  void changeFavorite(Map<String, int> favoriteModel) async {
    try {
      favorites[favoriteModel["product_id"]] =
          !favorites[favoriteModel["product_id"]];
      //emit(HomeChangeFavoritesSuccessState());
      Response response = await HomeApiService.changeFavorites(
        path: FAVORITES,
        data: favoriteModel,
        token: PreferenceUtils.getData(userTokenKey),
      );
      favoriteResponseModel = FavoriteResponseModel.fromJson(response.data);
      if (!favoriteResponseModel.status) {
        errorChangeFavorite(favoriteModel);
      } else {
        getFavorites();
        emit(HomeChangeFavoritesSuccessState(favoriteResponseModel));
      }
    } catch (e) {
      errorChangeFavorite(favoriteModel);
    }
  }

  void errorChangeFavorite(Map<String, int> model) {
    favorites[model["product_id"]] = !favorites[model["product_id"]];
    emit(HomeChangeFavoritesErrorState());
  }

  Future<void> getFavorites() async {
    emit(HomeLoadingFavoritesState());
    try {
      Response response = await HomeApiService.getFavorites(
        path: FAVORITES,
        token: PreferenceUtils.getData(userTokenKey),
      );
      favorite = Favorites.fromJson(response.data);
      if (favorite.status) {
        isGetFavorites = true;
        emit(HomeSuccessFavoritesState());
      } else {
        emit(HomeErrorFavoritesState());
      }
    } catch (e) {
      emit(HomeErrorFavoritesState());
    }
  }

  Future<void> getProfileData() async {
    emit(HomeLoadingProfileState());
    try {
      Response response = await HomeApiService.getProfile(
        path: PROFILE,
        token: PreferenceUtils.getData(userTokenKey),
      );

      userDataModel = LoginResponseModel.fromJson(response.data);

      if (userDataModel.status) {
        isGetProfile = true;
        emit(HomeSuccessProfileState());
      } else {
        emit(HomeErrorProfilesState());
      }
    } catch (e) {
      emit(HomeErrorProfilesState());
    }
  }

  Future<void> updateProfileData({
    String name,
    String email,
    String phone,
  }) async {
    emit(HomeLoadingUpdateUserState());
    try {
      Response response = await HomeApiService.updateProfile(
        path: UPDATE_PROFILE,
        data: {
          'name': name,
          'email': email,
          'phone': phone,
        },
        token: PreferenceUtils.getData(userTokenKey),
      );
      userDataModel = LoginResponseModel.fromJson(response.data);

      if (userDataModel.status) {
        emit(HomeSuccessUpdateUserState());
      } else {
        emit(HomeErrorUpdateUserState());
      }
    } catch (e) {
      emit(HomeErrorProfilesState());
    }
  }

  void getAllData() async {
    await getCategoryData();
    await getFavorites();
    await getProfileData();
    if (isGetCategories && isGetFavorites && isGetProfile) {
      emit(HomeDataSuccessState());
    } else {
      emit(HomeDataErrorState());
    }
  }
}
