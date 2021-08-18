part of 'categories_bloc.dart';

@immutable
abstract class CategoriesEvent {
  const CategoriesEvent();
}

class GetCategoriesDataEvent extends CategoriesEvent {
  final String language;

  const GetCategoriesDataEvent(this.language);
}
