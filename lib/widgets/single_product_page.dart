import 'package:cached_network_image/cached_network_image.dart';
import 'package:grad/business_logic/cart/bloc/bloc/cart_bloc.dart';
import 'package:grad/business_logic/home/bloc/home_bloc.dart';
import 'package:grad/core/DI/dependency_injection.dart';
import 'package:grad/core/helpers/constants/fonts/font_helper.dart';
import 'package:grad/models/category_response_model.dart';
import 'package:grad/core/theming/theme.dart';
import 'package:flutter/material.dart';
import 'package:grad/models/hot_deal_model.dart';
import 'package:grad/presentation/cart/widgets/cart_product.dart';
import 'package:grad/presentation/cart/widgets/product.dart';
import 'package:iconly/iconly.dart';
import 'package:readmore/readmore.dart';

class SingleProductPage extends StatelessWidget {
  static const String routeName = 'singleProdPage';
  final CategoryResponseModel? categoryResponseModel;
  final HotDealModel? hotDealModel;
  const SingleProductPage(
      {super.key, this.categoryResponseModel, this.hotDealModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(IconlyLight.arrow_left_2,
              color: Theme.of(context).textTheme.headlineSmall?.color),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Text(
                categoryResponseModel != null
                    ? categoryResponseModel!.title!
                    : hotDealModel!.title,
                style: FontHelper.poppins24Bold().copyWith(fontSize: 27),
              ),
              const SizedBox(height: 10),
              Text(
                "${categoryResponseModel != null ? categoryResponseModel!.category : hotDealModel!.discountedPrice}",
                style: FontHelper.poppins18Regular(),
              ),
              const SizedBox(height: 10),
              CachedNetworkImage(
                imageUrl: categoryResponseModel != null
                    ? categoryResponseModel!.image!
                    : hotDealModel!.image,
                width: double.infinity,
                height: 300,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 10),
              Text(
                "\$ ${categoryResponseModel != null ? categoryResponseModel!.price : hotDealModel!.discountedPrice}",
                style: FontHelper.poppins24Bold().copyWith(fontSize: 30),
              ),
              const SizedBox(height: 10),
              ReadMoreText(
                categoryResponseModel!.description ?? hotDealModel!.description,
                style: Theme.of(context).textTheme.titleMedium,
                trimLines: 4,
                colorClickableText: MyTheme.mainColor,
                lessStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: MyTheme.mainColor),
                trimMode: TrimMode.Line,
                trimCollapsedText: ' Show more',
                trimExpandedText: ' Show less',
                moreStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: MyTheme.mainColor),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12.0),
        child: BottomAppBar(
            color: Colors.transparent,
            elevation: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                      color: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.color
                          ?.withAlpha(20),
                      borderRadius: BorderRadius.circular(50)),
                  child: IconButton(
                      onPressed: () {
                        getIt<HomeBloc>().add(HomeAddToWishlistEvent(
                          categoryResponseModel: categoryResponseModel!,
                        ));
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("Added to wishlist"),
                          backgroundColor: MyTheme.mainColor,
                          duration: Duration(seconds: 1),
                        ));
                      },
                      icon: Icon(
                        IconlyLight.heart,
                        size: 30,
                        color: Theme.of(context).textTheme.headlineSmall?.color,
                      )),
                ),
                GestureDetector(
                  onTap: () {
                    addToCart(context, categoryResponseModel!);
                  },
                  child: Container(
                      width: 200,
                      height: 70,
                      decoration: BoxDecoration(
                          color: MyTheme.mainColor,
                          borderRadius: BorderRadius.circular(50)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            IconlyLight.bag,
                            size: 30,
                            color: Colors.white,
                          ),
                          Text("Add to cart",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(color: Colors.white))
                        ],
                      )),
                ),
              ],
            )),
      ),
    );
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
}
