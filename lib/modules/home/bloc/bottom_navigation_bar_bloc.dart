import 'dart:async';

import 'package:flutter/material.dart';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bottom_navigation_bar_event.dart';

part 'bottom_navigation_bar_state.dart';

class BottomNavigationBarBloc
    extends Bloc<BottomNavigationBarEvent, HomeBottomNavigationBarState> {
  BottomNavigationBarBloc() : super(HomeBottomNavigationInitialState());

  static BottomNavigationBarBloc get(BuildContext context) =>
      BlocProvider.of(context);

  @override
  Stream<HomeBottomNavigationBarState> mapEventToState(
    BottomNavigationBarEvent event,
  ) async* {
    if (event is NavigationToProductScreenEvent) {
      yield HomeBottomNavigationProductsState(event.index);
    } else if (event is NavigationToCategoriesScreenEvent) {
      yield HomeBottomNavigationCategoriesState(event.index);
    } else if (event is NavigationToFavoritesScreenEvent) {
      yield HomeBottomNavigationFavoritesState(event.index);
    } else if (event is NavigationToSettingsScreenEvent) {
      yield HomeBottomNavigationSettingsState(event.index);
    }
  }
}
