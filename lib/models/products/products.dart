import 'products_data.dart';

class Products {
  bool status;
  ProductsData productsData;

  Products({
    this.status,
    this.productsData,
  });

  Products.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    productsData =
        json['data'] != null ? ProductsData.fromJson(json['data']) : null;
  }
}
