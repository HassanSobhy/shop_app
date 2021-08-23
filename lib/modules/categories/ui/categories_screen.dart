import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/categories/categories.dart';
import 'package:shop_app/models/categories/category.dart';
import 'package:shop_app/modules/categories/bloc/categories_bloc.dart';

class CategoriesScreen extends StatefulWidget {
  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  Categories categories;

  @override
  void initState() {
    super.initState();
    if (categories == null) {
      getCategories();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesBloc, CategoriesState>(
      builder: (context, state) {
        if (state is CategoriesLoadingState) {
          return loadingWidget();
        } else if (state is CategoriesSuccessState) {
          categories = state.categories;
          return categoriesWidget(state.categories);
        } else if (state is CategoriesErrorState) {
          return errorWidget(context);
        } else {
          return defaultWidget();
        }
      },
    );
  }

  //////////////////////////////////////////
  ///////helper function///////////////////
  ////////////////////////////////////////

  void getCategories() {
    CategoriesBloc.get(context).add(const GetCategoriesDataEvent("en"));
  }

  Widget defaultWidget() {
    if (categories == null) {
      return Center(
        child: Container(),
      );
    } else {
      return categoriesWidget(categories);
    }
  }

  Widget categoriesWidget(Categories categories) {
    return ListView.separated(
      itemBuilder: (context, index) {
        final Category category =
            categories.categoriesData.categoryDataList[index];
        return categoryWidget(category);
      },
      separatorBuilder: (context, index) => dividerWidget(),
      itemCount: categories.categoriesData.categoryDataList.length,
    );
  }

  Widget categoryWidget(Category model) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Image(
            image: NetworkImage(model.image),
            width: 80.0,
            height: 80.0,
            fit: BoxFit.cover,
          ),
          const SizedBox(
            width: 20.0,
          ),
          Text(
            model.name,
            style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          const Icon(
            Icons.arrow_forward_ios,
          ),
        ],
      ),
    );
  }

  Widget errorWidget(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Data Loading Failed",
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: 200,
            height: 200,
            child: Image.asset("assets/images/error.png"),
          ),
          ElevatedButton(
            onPressed: getCategories,
            child: const Text("Refresh"),
          )
        ],
      ),
    );
  }

  Widget dividerWidget() {
    return const Divider(
      thickness: 1,
      color: Colors.grey,
    );
  }

  Widget loadingWidget() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
