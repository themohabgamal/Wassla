import 'package:grad/business_logic/home/bloc/home_bloc.dart';
import 'package:grad/business_logic/theming/cubit/theming_cubit.dart';
import 'package:grad/presentation/cart/cart_screen.dart';
import 'package:grad/core/theming/theme.dart';
import 'package:grad/widgets/home_single_product_args.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:readmore/readmore.dart';

class SingleProductPage extends StatelessWidget {
  static const String routeName = 'singleProdPage';
  const SingleProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as HomeToSingleProductArgs;
    ThemingCubit themingCubit =
        BlocProvider.of<ThemingCubit>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(IconlyLight.arrow_left_2,
              color: Theme.of(context).textTheme.headlineSmall?.color),
          onPressed: () {
            args.homeBloc.add(GoBackEvent());
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
                "${args.categoryResponseModel?.title}",
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),
              Text(
                "${args.categoryResponseModel?.category}",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontSize: 22, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 10),
              Image.network(
                "${args.categoryResponseModel?.image}",
                width: double.infinity,
                height: 300,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 10),
              Text(
                "\$ ${args.categoryResponseModel?.price}",
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontSize: 28,
                    color: MyTheme.mainColor,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),
              ReadMoreText(
                "${args.categoryResponseModel?.description}",
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
                      onPressed: () {},
                      icon: Icon(
                        IconlyLight.heart,
                        size: 30,
                        color: Theme.of(context).textTheme.headlineSmall?.color,
                      )),
                ),
                GestureDetector(
                  onTap: () {
                    args.homeBloc.add(HomeAddToCartEvent(
                        categoryResponseModel: args.categoryResponseModel!));
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
}
