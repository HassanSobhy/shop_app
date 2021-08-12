part of 'bottom_navigation_bar_bloc.dart';

@immutable
abstract class HomeBottomNavigationBarState {}

class HomeBottomNavigationInitialState extends HomeBottomNavigationBarState {}

class HomeBottomNavigationProductsState extends HomeBottomNavigationBarState {
  final int index;

  HomeBottomNavigationProductsState(this.index);
}

class HomeBottomNavigationCategoriesState extends HomeBottomNavigationBarState {
  final int index;

  HomeBottomNavigationCategoriesState(this.index);
}

class HomeBottomNavigationFavoritesState extends HomeBottomNavigationBarState {
  final int index;

  HomeBottomNavigationFavoritesState(this.index);
}

class HomeBottomNavigationSettingsState extends HomeBottomNavigationBarState {
  final int index;

  HomeBottomNavigationSettingsState(this.index);
}
