// ignore_for_file: prefer_const_literals_to_create_immutables

import 'dart:developer';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:grad/core/DI/dependency_injection.dart';
import 'package:grad/core/networking/firebase_helper.dart';
import 'package:grad/presentation/cart/cart_screen.dart';
import 'package:grad/presentation/home/hot_deals_page.dart';
import 'package:grad/presentation/home/widgets/carousel_slider_widget.dart';
import 'package:grad/presentation/home/widgets/home_categories.dart';
import 'package:grad/presentation/home/widgets/my_search_widget.dart';
import 'package:grad/presentation/wishlist/wish_list_screen.dart';
import 'package:grad/core/theming/theme.dart';
import 'package:grad/repos/category/category_repo.dart';
import 'package:grad/widgets/customized_api_home_widget.dart';
import 'package:grad/widgets/home_single_product_args.dart';
import 'package:grad/widgets/single_product_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import '../../business_logic/home/bloc/home_bloc.dart';
import '../../models/category/category_model.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'Home';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeBloc homeBloc = HomeBloc();
  FirebaseHelper firebaseHelper = FirebaseHelper();
  String firstName = '';
  String lastName = '';
  List<CategoryModel> categoriesList = [];
  List<String> categories = [
    "Sports",
    "Clothes",
    "Electronics",
    "Furniture",
    "Shoes",
  ];
  List<String> categoriesIcons = [
    "assets/icons/sports.png",
    "assets/icons/clothes.png",
    "assets/icons/electronics.png",
    "assets/icons/furniture.png",
    "assets/icons/shoes.png"
  ];
  int current = 0;
  String category = "electronics";
  @override
  void initState() {
    super.initState();
    getIt.get<FirebaseHelper>().getCurrentUserData().then((user) {
      if (user != null) {
        setState(() {
          firstName = user.firstName;
          lastName = user.lastName;
        });
      }
    });
    getAllCategories();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {
        if (state is NavigateToCartState) {
          Navigator.pushNamed(context, CartScreen.routeName,
              arguments: homeBloc);
        } else if (state is NavigateToSingleProductState) {
          Navigator.pushNamed(context, SingleProductPage.routeName,
              arguments: HomeToSingleProductArgs(
                  categoryResponseModel: state.categoryResponseModel,
                  homeBloc: homeBloc));
        } else if (state is NavigateToHotDealsState) {
          Navigator.pushNamed(context, HotDealsPage.routeName,
              arguments: homeBloc);
          homeBloc.add(HotDealsLoadedEvent());
        } else if (state is NavigateToWishlistState) {
          Navigator.pushNamed(context, WishListScreen.routeName);
        } else if (state is GoBackState) {
          Navigator.pop(context);
        } else if (state is AddToCartState) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
              "Item was added to your cart",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            backgroundColor: MyTheme.mainColor,
            duration: Duration(seconds: 1),
          ));
        } else if (state is AddToWishlistState) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
              "Item was added to your wishlist",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            backgroundColor: MyTheme.mainColor,
            duration: Duration(seconds: 1),
          ));
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: MyTheme.mainColor,
          //*-------------------------------------------------------------body------------------------------------------------
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Container(
                          color: MyTheme.mainColor,
                          width: double.infinity,
                          height: 200.h,
                        ),
                        const Positioned(
                          right: -200,
                          top: -110,
                          child: CircleAvatar(
                            radius: 200,
                            backgroundColor: Colors.white12,
                          ),
                        ),
                        const Positioned(
                          right: -200,
                          top: 50,
                          child: CircleAvatar(
                            radius: 200,
                            backgroundColor: Colors.white12,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 30, right: 10, left: 10),
                          child: Column(
                            children: [
                              HeaderWidget(
                                  firstName: firstName, lastName: lastName),
                              SizedBox(height: 40.h),
                              const MySearchWidget(),
                              SizedBox(
                                height: 20.h,
                              ),
                              HomeCategories(
                                  categoriesIcons: categoriesIcons,
                                  categories: categories,
                                  current: current)
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20))),
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 12, left: 12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const CarouselSliderBuilder(),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Popular Products",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall,
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        homeBloc.add(NavigateToHotDealsEvent());
                                      },
                                      //fake commit
                                      child: Text(
                                        "View all",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.copyWith(
                                                fontWeight: FontWeight.w600,
                                                color: MyTheme.mainColor),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height,
                                    child: CustomizedApiHomeWidget(
                                        homeBloc: homeBloc,
                                        category: category)),
                                SizedBox(height: 20.h),
                                HotDealsSection(
                                  homeBloc: homeBloc,
                                ),
                                SizedBox(height: 20.h),
                                Text(
                                  "Clothes",
                                  style:
                                      Theme.of(context).textTheme.headlineSmall,
                                ),
                                SizedBox(height: 20.h),
                                SizedBox(
                                    child: CustomizedApiHomeWidget(
                                        homeBloc: homeBloc,
                                        category: "men's clothing")),
                                const SizedBox(height: 20),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ]),
            ),
          ),
        );
      },
    );
  }

  getAllCategories() async {
    categoriesList = await getIt<CategoryRepo>().getAllCategories();
    log(categoriesList.toString());
  }
}

class HotDealsSection extends StatelessWidget {
  final HomeBloc? homeBloc;
  const HotDealsSection({super.key, this.homeBloc});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Hot Deals",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            TextButton(
              onPressed: () {
                homeBloc?.add(NavigateToHotDealsEvent());
              },
              //fake commit
              child: Text(
                "View all",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600, color: MyTheme.mainColor),
              ),
            )
          ],
        ),
        const SizedBox(height: 5),
        SizedBox(
          width: double.infinity,
          child: Stack(
            alignment: Alignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  "assets/images/pattern.jpg",
                  height: 100,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
              const Text(
                "50% off",
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 50,
                    color: Colors.white),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class HeaderWidget extends StatelessWidget {
  final String firstName;
  final String lastName;
  const HeaderWidget({
    super.key,
    required this.firstName,
    required this.lastName,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Good day for shopping",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.white)),
            Text(
                firstName == ''
                    ? ""
                    : "${firstName[0].toUpperCase() + firstName.substring(1)} $lastName",
                style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: Colors.white)),
          ],
        ),
        IconButton(
          icon: const Icon(
            IconlyLight.bag,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () {},
        )
      ],
    );
  }
}
