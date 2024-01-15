// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grad/presentation/auth/authenticated_screen.dart';
import 'package:grad/presentation/auth/non_authenticated_screen.dart';
import 'package:grad/presentation/cart/cart_screen.dart';
import 'package:grad/presentation/home/hot_deals_page.dart';
import 'package:grad/presentation/home/widgets/my_search_widget.dart';
import 'package:grad/presentation/wishlist/wish_list_screen.dart';
import 'package:grad/theming/theme.dart';
import 'package:grad/widgets/category_name_widget.dart';
import 'package:grad/widgets/customized_api_home_widget.dart';
import 'package:grad/widgets/home_single_product_args.dart';
import 'package:grad/widgets/single_product_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';

import '../../business_logic/home/bloc/home_bloc.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'Home';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeBloc homeBloc = HomeBloc();
  List<String> categories = [
    "electronics",
    "jewelery",
    "men's clothing",
    "women's clothing"
  ];

  int current = 0;
  String category = "electronics";
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
          // drawer: StreamBuilder<User?>(
          //   stream: FirebaseAuth.instance.authStateChanges(),
          //   builder: (context, snapshot) {
          //     if (snapshot.hasData) {
          //       return const AuthenticatedScreen();
          //     } else {
          //       return const NonAuthenticatedScreen();
          //     }
          //   },
          // ),

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
                          right: -120,
                          child: CircleAvatar(
                            radius: 120,
                            backgroundColor: Colors.white12,
                          ),
                        ),
                        const Positioned(
                          right: -120,
                          top: 25,
                          child: CircleAvatar(
                            radius: 100,
                            backgroundColor: Colors.white12,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 16, left: 16, top: 20),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Good day for shopping",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.white)),
                                      Text("Mohab Gamal",
                                          style: TextStyle(
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
                              ),
                              SizedBox(height: 40.h),
                              const MySearchWidget(),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 1.2,
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20))),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 12, left: 12, top: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Select Category",
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                height: 75,
                                child: ListView.separated(
                                  physics: const ClampingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          current = index;
                                          category = categories[index];
                                        });
                                      },
                                      child: CategoryNameWidget(
                                          name: categories[index],
                                          isSelected:
                                              index == current ? true : false),
                                    );
                                  },
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(width: 10),
                                  itemCount: 4,
                                ),
                              ),
                              SizedBox(height: 40.h),
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.36,
                                  child: CustomizedApiHomeWidget(
                                      homeBloc: homeBloc, category: category)),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Hot Deals",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall,
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      homeBloc.add(NavigateToHotDealsEvent());
                                    },
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
                              const SizedBox(height: 20),
                              Text(
                                "Clothes",
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              ),
                              const SizedBox(height: 20),
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.35,
                                  child: CustomizedApiHomeWidget(
                                      homeBloc: homeBloc,
                                      category: "men's clothing")),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ],
                    )
                  ]),
            ),
          ),
        );
      },
    );
  }
}
