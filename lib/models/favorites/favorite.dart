import 'package:shop_app/models/favorites/favorite_data.dart';

class Favorites {
  bool status;
  String message;
  FavoritesData favoritesData;

  Favorites({this.status, this.message, this.favoritesData});

  Favorites.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    favoritesData =
        json['data'] != null ? FavoritesData.fromJson(json['data']) : null;
  }
}
