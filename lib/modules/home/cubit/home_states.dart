import 'package:shop_app/models/favorites_models/favorite_response_model.dart';

abstract class HomeStates {}

class HomeInitialState extends HomeStates{}

class HomeChangeBottomNavState extends HomeStates{}

class HomeLoadingState extends HomeStates{}

class HomeSuccessState extends HomeStates{}

class HomeErrorState extends HomeStates{}

class HomeCategorySuccessState extends HomeStates {}

class HomeCategoryErrorState extends HomeStates {}

class HomeDataSuccessState extends HomeStates{}

class HomeDataErrorState extends HomeStates{}

//Favorite in Home Screen State
class HomeChangeFavoritesSuccessState extends HomeStates{
  final FavoriteResponseModel model;

  HomeChangeFavoritesSuccessState(this.model);

}

class HomeChangeFavoritesErrorState extends HomeStates{}
//Favorite in Home Screen State


//Favorite Screen State
class HomeLoadingFavoritesState extends HomeStates {}

class HomeSuccessFavoritesState extends HomeStates {}

class HomeErrorFavoritesState extends HomeStates {}
//Favorite Screen State

//Profile Screen State
class HomeLoadingProfileState extends HomeStates {}

class HomeSuccessProfileState extends HomeStates {}

class HomeErrorProfilesState extends HomeStates {}
//Profile Screen State

//Update User State Screen State
class HomeLoadingUpdateUserState extends HomeStates {}

class HomeSuccessUpdateUserState extends HomeStates {}

class HomeErrorUpdateUserState extends HomeStates {}
//Update User State