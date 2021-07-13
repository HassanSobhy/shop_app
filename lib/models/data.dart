import 'banner.dart';
import 'product.dart';

class Data {
  List<Banner> banners;
  List<Product> products;
  String ad;

  Data({
    this.banners,
    this.products,
    this.ad,
  });

  //Convert from JSON To Data Model
  Data.fromJson(Map<String, dynamic> json) {
    if (json['banners'] != null) {
      banners = <Banner>[];
      json['banners'].forEach((element) {
        banners.add(Banner.fromJson(element));
      });
    }
    if (json['products'] != null) {
      products = <Product>[];
      json['products'].forEach((element) {
        products.add(Product.fromJson(element));
      });
    }
    ad = json['ad'];
  }
}
