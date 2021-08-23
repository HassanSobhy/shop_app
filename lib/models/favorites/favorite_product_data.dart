import 'package:shop_app/models/products/product.dart';

class FavoriteProductData {
  int id;
  Product product;

  FavoriteProductData({this.id, this.product});

  FavoriteProductData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product =
        json['product'] != null ? Product.fromJson(json['product']) : null;
  }
}
