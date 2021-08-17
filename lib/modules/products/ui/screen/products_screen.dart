import 'package:flutter/material.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/models/favorites/favorite_model.dart';

import 'package:shop_app/models/products/products.dart';
import 'package:shop_app/models/products/product.dart';
import 'package:shop_app/modules/products/bloc/products_bloc.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Products products;
    return BlocConsumer<ProductsBloc, ProductsState>(
      listener: (context, state) {
        if (state is ProductsErrorState) {
          final String message = state.message;
          buildToastMessage(message, Colors.red);
        }
      },
      builder: (context, state) {
        if (state is ProductsLoadingState) {
          return loadingWidget();
        } else if (state is ProductsSuccessState) {
          products = state.products;
          return buildProductBody(context, products);
        } else if (state is ProductsErrorState) {
          return errorWidget(context);
        } else {
          return errorWidget(context);
        }
      },
    );
  }

  Widget loadingWidget() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget errorWidget(BuildContext context) {
    return Center(
      child: Column(
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
            onPressed: () {
              ProductsBloc.get(context).add(const GetProductDataEvent("en"));
            },
            child: const Text("Refresh"),
          )
        ],
      ),
    );
  }

  Widget buildCarouselSlider(Products homeData) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: CarouselSlider(
        items: homeData.productsData.banners
            .map((element) => Image(
                  image: NetworkImage(
                    element.image,
                  ),
                  width: double.infinity,
                  fit: BoxFit.cover,
                ))
            .toList(),
        options: CarouselOptions(
          height: 250.0,
          viewportFraction: 1.0,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 3),
          autoPlayAnimationDuration: const Duration(seconds: 1),
        ),
      ),
    );
  }

  Widget buildProductBody(BuildContext context, Products products) {
    return SingleChildScrollView(
      child: Column(
        children: [
          buildCarouselSlider(products),
          const SizedBox(height: 10),
          buildGridView(context, products),
        ],
      ),
    );
  }

  Widget buildGridView(BuildContext context, Products products) {
    return Container(
      color: Colors.grey[300],
      child: GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        mainAxisSpacing: 1.0,
        crossAxisSpacing: 1.0,
        childAspectRatio: 1 / 1.7,
        children: List.generate(
          products.productsData.products.length,
          (index) =>
              buildGridProduct(products.productsData.products[index], context),
        ),
      ),
    );
  }

  Widget buildGridProduct(Product product, BuildContext context) => Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(product.image),
                  width: double.infinity,
                  height: 200.0,
                ),
                if (product.discount != 0)
                  Container(
                    color: Colors.red,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5.0,
                    ),
                    child: const Text(
                      'DISCOUNT',
                      style: TextStyle(
                        fontSize: 8.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14.0,
                      height: 1.3,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        '${product.price.round()}',
                        style: const TextStyle(
                          fontSize: 12.0,
                          color: Colors.deepOrange,
                        ),
                      ),
                      const SizedBox(
                        width: 5.0,
                      ),
                      if (product.discount != 0)
                        Text(
                          '${product.oldPrice.round()}',
                          style: const TextStyle(
                            fontSize: 10.0,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      const Spacer(),
                      CircleAvatar(
                        radius: 15,
                        backgroundColor: ProductsBloc.get(context)
                                .favoriteProducts[product.id]
                            ? Colors.deepOrange
                            : Colors.grey,
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          icon: const Icon(
                            Icons.favorite_border,
                            size: 14.0,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            final FavoriteModel favoriteModel =
                                FavoriteModel(productId: product.id);
                            ProductsBloc.get(context).add(
                                ChangeFavoriteProductEvent(
                                    favoriteModel.toMap(), "en"));
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  void buildToastMessage(String message, Color color) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: color,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}