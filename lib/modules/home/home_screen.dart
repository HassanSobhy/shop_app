import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shop_app/modules/categories/ui/categories_screen.dart';
import 'package:shop_app/modules/favorites/favorites_screen.dart';
import 'package:shop_app/modules/home/bloc/bottom_navigation_bar_bloc.dart';
import 'package:shop_app/modules/products/ui/screen/products_screen.dart';
import 'package:shop_app/modules/settings/settings_screen.dart';
import 'package:shop_app/modules/search/search_screen.dart';
import 'package:shop_app/utils/lang/app_localization.dart';
import 'package:shop_app/utils/lang/app_localization_keys.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavigationBarBloc, HomeBottomNavigationBarState>(
      builder: (context, state) {
        if (state is HomeBottomNavigationProductsState) {
          return homeWidget(context, ProductsScreen(), state.index);
        } else if (state is HomeBottomNavigationCategoriesState) {
          return homeWidget(context, CategoriesScreen(), state.index);
        } else if (state is HomeBottomNavigationFavoritesState) {
          return homeWidget(context, FavoritesScreen(), state.index);
        } else if (state is HomeBottomNavigationSettingsState) {
          return homeWidget(context, SettingsScreen(), state.index);
        } else {
          return homeWidget(context, ProductsScreen());
        }
      },
    );
  }

  ///////////////////////////////////////////////////////////
  //////////////////// Widget methods ///////////////////////
  ///////////////////////////////////////////////////////////

  Widget homeWidget(BuildContext context, Widget body, [int index = 0]) {
    final appLocal = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          appLocal.translate(LangKeys.APP_NAME),
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          searchButtonWidget(context),
        ],
      ),
      body: body,
      bottomNavigationBar: bottomNavigationBarWidget(context, index),
    );
  }

  Widget searchButtonWidget(BuildContext context) {
    return IconButton(
        onPressed: () {
          navigateToSearchScreen(context);
        },
        icon: const Icon(
          Icons.search,
          color: Colors.black,
        ));
  }

  Widget bottomNavigationBarWidget(BuildContext context, int index) {
    return BottomNavigationBar(
      onTap: (index) => changeBottomNavBarIndex(context, index),
      currentIndex: index,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.apps), label: "Categories"),
        BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Favorites"),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
      ],
    );
  }

  ///////////////////////////////////////////////////////////
  //////////////////// Widget methods ///////////////////////
  ///////////////////////////////////////////////////////////

  ///////////////////////////////////////////////////////////
  /////////////////// Helper methods ////////////////////////
  ///////////////////////////////////////////////////////////

  void navigateToSearchScreen(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => SearchScreen()));
  }

  void changeBottomNavBarIndex(BuildContext context, int index) {
    if (index == 0) {
      BottomNavigationBarBloc.get(context)
          .add(NavigationToProductScreenEvent(index));
    } else if (index == 1) {
      BottomNavigationBarBloc.get(context)
          .add(NavigationToCategoriesScreenEvent(index));
    } else if (index == 2) {
      BottomNavigationBarBloc.get(context)
          .add(NavigationToFavoritesScreenEvent(index));
    } else if (index == 3) {
      BottomNavigationBarBloc.get(context)
          .add(NavigationToSettingsScreenEvent(index));
    }
  }
}
