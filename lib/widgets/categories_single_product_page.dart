import 'package:grad/business_logic/categories/bloc/categories_bloc.dart';
import 'package:grad/theming/theme.dart';
import 'package:grad/widgets/categories_single_product_args.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:readmore/readmore.dart';

class CategoriesSingleProductPage extends StatelessWidget {
  static const String routeName = 'CategorySingleProdPage';

  const CategoriesSingleProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments
        as CategoriesToSingleProductArgs;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(IconlyLight.arrow_left_2, color: Colors.black),
          onPressed: () {
            args.categoriesBloc.add(CategoriesNavigateBackEvent());
          },
        ),
        actions: [
          IconButton(
            icon: Image.asset(
              "assets/images/bag.png",
              width: 30,
            ),
            onPressed: () {
              args.categoriesBloc.add(CategoriesAddToCartEvent(
                  categoryResponseModel: args.categoryResponseModel));
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Text(
                "${args.categoryResponseModel.title}",
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: Colors.black, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),
              Text(
                "${args.categoryResponseModel.category}",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontSize: 22,
                    color: MyTheme.darkGreyColor,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 10),
              Image.network(
                "${args.categoryResponseModel.image}",
                width: double.infinity,
                height: 300,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 10),
              Text(
                "\$ ${args.categoryResponseModel.price}",
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontSize: 28,
                    color: Colors.black,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),
              ReadMoreText(
                "${args.categoryResponseModel.description}",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: MyTheme.darkGreyColor),
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
                      color: Colors.grey.withAlpha(40),
                      borderRadius: BorderRadius.circular(50)),
                  child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        IconlyLight.heart,
                        size: 30,
                      )),
                ),
                Container(
                    width: 200,
                    height: 70,
                    decoration: BoxDecoration(
                        color: MyTheme.mainColor,
                        borderRadius: BorderRadius.circular(50)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              IconlyLight.bag,
                              size: 30,
                              color: Colors.white,
                            )),
                        Text("Add to cart",
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(color: Colors.white))
                      ],
                    )),
              ],
            )),
      ),
    );
  }
}
