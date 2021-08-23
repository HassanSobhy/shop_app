import 'package:shop_app/models/favorites/favorite_product_data.dart';

class FavoritesData {
  int currentPage;
  List<FavoriteProductData> productData;

  FavoritesData({
    this.currentPage,
    this.productData,
  });

  FavoritesData.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      productData = [];
      json['data'].forEach((v) {
        productData.add(FavoriteProductData.fromJson(v));
      });
    }
  }
}
