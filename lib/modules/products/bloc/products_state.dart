part of 'products_bloc.dart';

@immutable
abstract class ProductsState {
  const ProductsState();
}

class ProductsInitialState extends ProductsState {
  const ProductsInitialState();
}

class ProductsLoadingState extends ProductsState {
  const ProductsLoadingState();
}

class ProductsSuccessState extends ProductsState {
  final Products products;

  const ProductsSuccessState(this.products);
}

class ProductsErrorState extends ProductsState {
  final String message;

  const ProductsErrorState(this.message);
}

class CategoriesLoadingState extends ProductsState {
  const CategoriesLoadingState();
}

class CategoriesSuccessState extends ProductsState {
  final Categories categories;

  const CategoriesSuccessState(this.categories);
}

class CategoriesErrorState extends ProductsState {
  final String message;

  const CategoriesErrorState(this.message);
}

class ProductsChangeFavoritesSuccessState extends ProductsState {
  final String message;

  const ProductsChangeFavoritesSuccessState(this.message);
}

class ProductsChangeFavoritesErrorState extends ProductsState {
  final String message;

  const ProductsChangeFavoritesErrorState(this.message);
}
