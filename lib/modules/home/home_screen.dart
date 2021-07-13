import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/home/cubit/home_cubit.dart';
import 'package:shop_app/modules/home/cubit/home_states.dart';
import 'package:shop_app/modules/search/search_screen.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Salla", style: TextStyle(color: Colors.black),),
            actions: [
              IconButton(onPressed: (){
                navigateToSearchScreen(context);
              }, icon: Icon(Icons.search,color: Colors.black,)),
            ],
          ),
          body: HomeCubit.get(context).screens[HomeCubit.get(context).currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: HomeCubit.get(context).changeBottomNavIndex,
            currentIndex: HomeCubit.get(context).currentIndex,
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.apps), label: "Categories"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite), label: "Favorites"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: "Settings"),
            ],
          ),
        );
      },
    );
  }

  void navigateToSearchScreen(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => SearchScreen()));
  }

}
