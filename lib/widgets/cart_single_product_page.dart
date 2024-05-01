import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grad/business_logic/cart/bloc/bloc/cart_bloc.dart';
import 'package:grad/core/DI/dependency_injection.dart';
import 'package:grad/core/theming/theme.dart';
import 'package:grad/models/category_response_model.dart';
import 'package:grad/presentation/cart/widgets/cart_product.dart';
import 'package:grad/presentation/cart/widgets/product.dart';
import 'package:grad/widgets/alert.dart';
import 'package:grad/widgets/cart_single_product_args.dart';
import 'package:iconly/iconly.dart';
import 'package:readmore/readmore.dart';

class CartSingleProductPage extends StatelessWidget {
  static const String routeName = 'cartSingleProdPage';
  final CartToSingleProductPageArgs args;
  const CartSingleProductPage({super.key, required this.args});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(IconlyLight.arrow_left_2,
              color: Theme.of(context).textTheme.titleLarge?.color),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Text(
                  "${args.categoryResponseModel.title}",
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Theme.of(context).textTheme.titleLarge?.color,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 10),
                Text(
                  "${args.categoryResponseModel.category}",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontSize: 22,
                      color: Theme.of(context).textTheme.titleLarge?.color,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 10),
                CachedNetworkImage(
                  imageUrl: "${args.categoryResponseModel.image}",
                  width: double.infinity,
                  placeholder: (context, url) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                  height: 300,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 10),
                Text(
                  "\$ ${args.categoryResponseModel.price}",
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontSize: 28,
                      color: Theme.of(context).textTheme.titleLarge?.color,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 10),
                ReadMoreText(
                  "${args.categoryResponseModel.description}",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontSize: 16,
                      color: Theme.of(context).textTheme.titleLarge?.color),
                  trimLines: 4,
                  colorClickableText: MyTheme.mainColor,
                  lessStyle: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
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
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12.0),
        child: BottomAppBar(
          color: Colors.transparent,
          elevation: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(width: 1),
              GestureDetector(
                onTap: () {
                  addToCart(context, args.categoryResponseModel);
                },
                child: Container(
                  width: 200,
                  height: 70,
                  decoration: BoxDecoration(
                    color: MyTheme.mainColor,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        IconlyLight.bag,
                        size: 30,
                        color: Colors.white,
                      ),
                      SizedBox(width: 20.w),
                      const Text(
                        "Add To Cart",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
  Alert.showAlert(
      isLoading: false,
      context: context,
      animation: 'assets/animations/success.json',
      text: "Item Added To Cart",
      onContinue: () {
        Navigator.pop(context);
      });
}
