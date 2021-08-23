import 'package:shop_app/models/categories/category.dart';

class Banner {
  int id;
  String image;
  Category category;

  Banner({
    this.id,
    this.image,
    this.category,
  });

  //Convert from JSON To Banner Model Model
  Banner.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    category =
        json['category'] != null ? Category.fromJson(json['category']) : null;
  }
}
