import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shop_app/models/favorites_models/favorite_model.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/modules/home/cubit/home_cubit.dart';
import 'package:shop_app/modules/search/cubit/search_states.dart';
import 'cubit/search_cubit.dart';

class SearchScreen extends StatelessWidget {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController searchTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    TextFormField(
                      controller: searchTextController,
                      keyboardType: TextInputType.text,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Enter text to search';
                        }

                        return null;
                      },
                      onFieldSubmitted: (String text) {
                        SearchCubit.get(context).searchProducts(text);
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Search",
                        prefixIcon: Icon(Icons.search),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    if (state is SearchLoadingState) LinearProgressIndicator(),
                    SizedBox(
                      height: 10.0,
                    ),
                    if (state is SearchSuccessState)
                      Expanded(
                        child: ListView.separated(
                          itemBuilder: (context, index) => buildListProduct(
                            SearchCubit.get(context)
                                .searchModel
                                .data
                                .data[index],
                            context,
                          ),
                          separatorBuilder: (context, index) =>
                              buildListViewDivider(),
                          itemCount: SearchCubit.get(context)
                              .searchModel
                              .data
                              .data
                              .length,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildListViewDivider() {
    return Divider(
      thickness: 1,
      color: Colors.grey,
    );
  }

  Widget buildListProduct(ProductData product, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 120,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  fit: BoxFit.cover,
                  image: NetworkImage(product.image),
                ),
              ],
            ),
            SizedBox(width: 20.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${product.description}",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14.0,
                      height: 1.3,
                    ),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Text(
                        "${product.price}",
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.deepOrange,
                        ),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Spacer(),
                      IconButton(
                        onPressed: () {
                          //ShopCubit.get(context).changeFavorites(model.product.id);
                          FavoriteModel model =
                              FavoriteModel(productId: product.id);
                          HomeCubit.get(context).changeFavorite(model.toMap());
                        },
                        icon: CircleAvatar(
                          radius: 15.0,
                          backgroundColor:
                              HomeCubit.get(context).favorites[product.id]
                                  ? Colors.deepOrange
                                  : Colors.grey,
                          child: Icon(
                            Icons.favorite_border,
                            size: 14.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
