import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/category_models/categories_model.dart';
import 'package:shop_app/modules/home/cubit/home_cubit.dart';
import 'package:shop_app/modules/home/cubit/home_states.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ListView.separated(
          itemBuilder: (context, index) => buildCatItem(HomeCubit.get(context).categoriesModel.data.data[index]),
          separatorBuilder: (context, index) => buildListViewDivider(),
          itemCount: HomeCubit.get(context).categoriesModel.data.data.length,
        );
      },
    );
  }

  Widget buildCatItem(CategoriesData model) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Image(
              image: NetworkImage(model.image),
              width: 80.0,
              height: 80.0,
              fit: BoxFit.cover,
            ),
            SizedBox(
              width: 20.0,
            ),
            Text(
              model.name,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            Icon(
              Icons.arrow_forward_ios,
            ),
          ],
        ),
      );

  Widget buildListViewDivider() {
    return Divider(
      thickness: 1,
      color: Colors.grey,
    );
  }
}
