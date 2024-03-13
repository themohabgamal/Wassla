import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grad/business_logic/cart/bloc/bloc/cart_bloc.dart';
import 'package:grad/business_logic/categories/bloc/categories_bloc.dart';
import 'package:grad/business_logic/home/bloc/home_bloc.dart';
import 'package:grad/core/DI/dependency_injection.dart';
import 'package:grad/core/helpers/constants/fonts/font_helper.dart';
import 'package:grad/core/theming/theme.dart';
import 'package:grad/models/hot_deal_model.dart';
import 'package:grad/presentation/cart/widgets/cart_product.dart';
import 'package:grad/presentation/cart/widgets/product.dart';
import 'package:iconly/iconly.dart';

class HotDealTileWidget extends StatelessWidget {
  final HotDealModel hotDealModel;
  final HomeBloc? homeBloc;
  final CategoriesBloc? categoriesBloc;

  const HotDealTileWidget({
    super.key,
    required this.hotDealModel,
    this.homeBloc,
    this.categoriesBloc,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (homeBloc != null) {
          homeBloc
              ?.add(NavigateToSingleProductEvent(hotDealModel: hotDealModel));
        } else {
          categoriesBloc?.add(CategoriesNavigateToSingleProductPageEvent(
              hotDealModel: hotDealModel));
        }
      },
      child: Container(
        padding: const EdgeInsets.all(1),
        margin: const EdgeInsets.all(7),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFb4b4b4).withOpacity(0.4),
              offset: const Offset(4, 4),
              blurRadius: 7,
              spreadRadius: 4,
            ),
          ],
          borderRadius: BorderRadius.circular(15),
          color: Theme.of(context).canvasColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 2,
              child: CachedNetworkImage(
                imageUrl: hotDealModel.image,
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => Column(
                  children: [
                    const Icon(
                      Icons.error,
                    ),
                    Text(error.toString())
                  ],
                ),
                width: double.infinity,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: 20.h),
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${categoryTitleBuilder(hotDealModel.title)}",
                          style: FontHelper.poppins18Regular(),
                        ),
                        Text(
                          hotDealModel.description,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: FontHelper.poppins16Bold().copyWith(
                            fontWeight: FontWeight.w300,
                            fontSize: 15,
                            color: Colors.grey[500],
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          "${hotDealModel.originalPrice}",
                          style: FontHelper.poppins16Bold().copyWith(
                              fontWeight: FontWeight.w400,
                              fontSize: 18,
                              color: Colors.black,
                              decorationThickness: 2,
                              decorationColor: Colors.red,
                              decoration: TextDecoration.lineThrough),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Flexible(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "${formatPrice(hotDealModel.discountedPrice)} EGP",
                            style: FontHelper.poppins20Bold(),
                            maxLines: 1,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  // if (homeBloc != null) {
                                  //   homeBloc?.add(HomeAddToWishlistEvent(
                                  //     categoryResponseModel:
                                  //         categoryResponseModel,
                                  //   ));
                                  // } else {
                                  //   categoriesBloc?.add(
                                  //     CategoriesAddToWishlistEvent(
                                  //       categoryResponseModel:
                                  //           categoryResponseModel,
                                  //     ),
                                  //   );
                                  // }
                                },
                                child: const Icon(
                                  IconlyLight.heart,
                                  size: 25,
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(width: 5.w),
                              GestureDetector(
                                onTap: () {
                                  addToCart(context, hotDealModel);
                                },
                                child: const Icon(Icons.shopping_cart,
                                    size: 25, color: Colors.black),
                              ),
                            ],
                          )
                        ]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String? categoryTitleBuilder(String? title) {
    if (title!.length > 30) {
      return "${title.substring(0, 25)}...";
    } else {
      return title;
    }
  }

  String formatPrice(num price) {
    if (price.toString().length > 5) {
      // Replace the last digit with "~"
      String truncatedPrice =
          '${price.toString().substring(0, price.toString().length - 3)}~';

      return truncatedPrice;
    } else {
      // Return the original price formatted with 2 decimal places
      return price.toString();
    }
  }
}

void addToCart(BuildContext context, HotDealModel hotDealModel) {
  final cartBloc = getIt<CartBloc>();
  Product productToAdd = Product(
    imageUrl: hotDealModel.image,
    name: hotDealModel.title,
    price: hotDealModel.discountedPrice,
  );
  CartProduct cartProduct = CartProduct(product: productToAdd, quantity: 1);
  cartBloc.addToCart(cartProduct);
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: MyTheme.mainColor,
      duration: const Duration(seconds: 1),
      content: Text(
        "Product was added to cart",
        style: FontHelper.poppins16Bold().copyWith(color: Colors.white),
      )));
}
