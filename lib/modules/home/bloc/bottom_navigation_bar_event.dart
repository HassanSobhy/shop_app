part of 'bottom_navigation_bar_bloc.dart';

@immutable
abstract class BottomNavigationBarEvent {}

class NavigationToProductScreenEvent extends BottomNavigationBarEvent {}

class NavigationToCategoriesScreenEvent extends BottomNavigationBarEvent {}

class NavigationToFavoritesScreenEvent extends BottomNavigationBarEvent {}

class NavigationToSettingsScreenEvent extends BottomNavigationBarEvent {}
