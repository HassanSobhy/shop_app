import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shop_app/models/categories/categories.dart';
import 'package:shop_app/modules/categories/bloc/categories_repository.dart';

part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  BaseCategoriesRepository categoriesRepository;

  CategoriesBloc() : super(const CategoriesInitialState());

  @override
  Stream<CategoriesState> mapEventToState(
    CategoriesEvent event,
  ) async* {
    if (event is GetCategoriesDataEvent) {
      yield const CategoriesLoadingState();
      yield await categoriesRepository.getCategoriesDate(event.language);
    }
  }
}
