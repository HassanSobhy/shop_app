import 'package:flutter/material.dart';

class FavoriteModel {
  int productId;

  FavoriteModel({
    @required this.productId,
  });

  Map<String, int> toMap() {
    return {
      'product_id': productId,
    };
  }
}
