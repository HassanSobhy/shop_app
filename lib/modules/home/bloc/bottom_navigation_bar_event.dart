part of 'bottom_navigation_bar_bloc.dart';

@immutable
abstract class BottomNavigationBarEvent {}

class NavigationToProductScreenEvent extends BottomNavigationBarEvent {
  final int index;

  NavigationToProductScreenEvent(this.index);
}

class NavigationToCategoriesScreenEvent extends BottomNavigationBarEvent {
  final int index;

  NavigationToCategoriesScreenEvent(this.index);
}

class NavigationToFavoritesScreenEvent extends BottomNavigationBarEvent {
  final int index;

  NavigationToFavoritesScreenEvent(this.index);
}

class NavigationToSettingsScreenEvent extends BottomNavigationBarEvent {
  final int index;

  NavigationToSettingsScreenEvent(this.index);
}
