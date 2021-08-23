import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/favorites/favorite_model.dart';

import 'package:shop_app/models/products/product.dart';
import 'package:shop_app/modules/home/cubit/home_cubit.dart';
import 'package:shop_app/modules/home/cubit/home_states.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ListView.separated(
          separatorBuilder: (context, index) {
            return buildListViewDivider();
          },
          itemBuilder: (context, index) {
            return buildFavListItem(
                HomeCubit.get(context)
                    .favorite
                    .favoritesData
                    .productData[index]
                    .product,
                context);
          },
          itemCount:
              HomeCubit.get(context).favorite.favoritesData.productData.length,
        );
      },
    );
  }

  Widget buildFavListItem(Product product, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: 120,
        child: Row(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  fit: BoxFit.cover,
                  image: NetworkImage(product.image),
                ),
                if (1 != 0)
                  Container(
                    color: Colors.red,
                    padding: EdgeInsets.symmetric(
                      horizontal: 5.0,
                    ),
                    child: Text(
                      'DISCOUNT',
                      style: TextStyle(
                        fontSize: 8.0,
                        color: Colors.white,
                      ),
                    ),
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
                      if (product.discount != 0)
                        Text(
                          "${product.oldPrice}",
                          style: TextStyle(
                            fontSize: 10.0,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
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

  Widget buildListViewDivider() {
    return Divider(
      thickness: 1,
      color: Colors.grey,
    );
  }
}
