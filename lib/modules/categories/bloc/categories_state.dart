part of 'categories_bloc.dart';

@immutable
abstract class CategoriesState {
  const CategoriesState();
}

class CategoriesInitialState extends CategoriesState {
  const CategoriesInitialState();
}

class CategoriesLoadingState extends CategoriesState {
  const CategoriesLoadingState();
}

class CategoriesSuccessState extends CategoriesState {
  final Categories categories;

  const CategoriesSuccessState(this.categories);
}

class CategoriesErrorState extends CategoriesState {
  final String message;

  const CategoriesErrorState(this.message);
}
