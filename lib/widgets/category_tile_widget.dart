import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grad/business_logic/cart/bloc/bloc/cart_bloc.dart';
import 'package:grad/business_logic/categories/bloc/categories_bloc.dart';
import 'package:grad/business_logic/home/bloc/home_bloc.dart';
import 'package:grad/core/DI/dependency_injection.dart';
import 'package:grad/core/helpers/constants/fonts/font_helper.dart';
import 'package:grad/core/theming/theme.dart';
import 'package:grad/models/category_response_model.dart';
import 'package:grad/presentation/cart/widgets/cart_product.dart';
import 'package:grad/presentation/cart/widgets/product.dart';
import 'package:grad/widgets/single_product_page.dart';
import 'package:iconly/iconly.dart';

class CategoryTileWidget extends StatelessWidget {
  final CategoryResponseModel categoryResponseModel;
  final HomeBloc? homeBloc;
  final CategoriesBloc? categoriesBloc;

  const CategoryTileWidget({
    super.key,
    required this.categoryResponseModel,
    this.homeBloc,
    this.categoriesBloc,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return SingleProductPage(
            categoryResponseModel: categoryResponseModel,
          );
        }));
      },
      child: Container(
        padding: const EdgeInsets.only(left: 3, right: 3, bottom: 7),
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
                imageUrl: categoryResponseModel.image!,
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
                          "${categoryTitleBuilder(categoryResponseModel.title)}",
                          style: FontHelper.poppins18Regular(),
                        ),
                        Text(
                          "${categoryResponseModel.description}",
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
                          "Quantity: ${categoryResponseModel.quantity}",
                          style: FontHelper.poppins16Bold().copyWith(
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                            color: MyTheme.mainColor,
                          ),
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
                            "${formatPrice(categoryResponseModel.price!)} EGP",
                            style: FontHelper.poppins16Bold(),
                            maxLines: 1,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  if (homeBloc != null) {
                                    homeBloc?.add(HomeAddToWishlistEvent(
                                      categoryResponseModel:
                                          categoryResponseModel,
                                    ));
                                  } else {
                                    categoriesBloc?.add(
                                      CategoriesAddToWishlistEvent(
                                        categoryResponseModel:
                                            categoryResponseModel,
                                      ),
                                    );
                                  }
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
                                  addToCart(context, categoryResponseModel);
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
          '${price.toString().substring(0, price.toString().length - 2)}~';

      return truncatedPrice;
    } else {
      // Return the original price formatted with 2 decimal places
      return price.toString();
    }
  }
}

void addToCart(
    BuildContext context, CategoryResponseModel categoryResponseModel) {
  final cartBloc = getIt<CartBloc>();
  Product productToAdd = Product(
    imageUrl: categoryResponseModel.image!,
    name: categoryResponseModel.title!,
    price: categoryResponseModel.price!,
  );
  CartProduct cartProduct = CartProduct(product: productToAdd, quantity: 1);
  cartBloc.addToCart(cartProduct);
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: MyTheme.mainColor,
      duration: const Duration(seconds: 1),
      content: Text(
        "Product was added to cart",
        style: FontHelper.poppins16Bold().copyWith(color: Colors.white),
      ),
    ),
  );
}
