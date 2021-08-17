import 'package:shop_app/models/categories/category.dart';

class CategoriesData {
  int currentPage;
  List<Category> categoryDataList = [];

  CategoriesData.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    json['data'].forEach((element) {
      categoryDataList.add(Category.fromJson(element));
    });
  }
}
