part of 'products_bloc.dart';

@immutable
abstract class ProductsEvent {
  const ProductsEvent();
}

class GetProductDataEvent extends ProductsEvent {
  final String language;

  const GetProductDataEvent(this.language);
}

class GetCategoriesDataEvent extends ProductsEvent {
  final String language;

  const GetCategoriesDataEvent(this.language);
}

class ChangeFavoriteProductEvent extends ProductsEvent {
  final Map<String, int> favoriteModel;
  final String language;

  const ChangeFavoriteProductEvent(this.favoriteModel, this.language);
}
