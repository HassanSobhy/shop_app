import 'package:shop_app/models/categories/categories_data.dart';

class Categories {
  bool status;
  CategoriesData categoriesData;

  Categories.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    categoriesData = CategoriesData.fromJson(json['data']);
  }
}
