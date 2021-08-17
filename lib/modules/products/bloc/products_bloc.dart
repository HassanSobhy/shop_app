import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shop_app/models/categories/categories.dart';
import 'package:shop_app/models/products/products.dart';
import 'package:shop_app/modules/products/bloc/products_repository.dart';

part 'products_event.dart';

part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final BaseProductsRepository productsRepository;

  ProductsBloc(this.productsRepository) : super(const ProductsInitialState());

  @override
  Stream<ProductsState> mapEventToState(
    ProductsEvent event,
  ) async* {
    if (event is GetProductDataEvent) {
      yield const ProductsLoadingState();
      yield await productsRepository.getProductsData(event.language);
    } else if (event is ChangeFavoriteProductEvent) {
      yield await productsRepository.setProductFavorite(
          event.favoriteModel, event.language);
    }
  }
}
