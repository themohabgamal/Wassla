import 'package:grad/business_logic/categories/bloc/categories_bloc.dart';
import 'package:grad/repositories/home_category_repo.dart';
import 'package:grad/core/theming/theme.dart';
import 'package:grad/widgets/categories_single_product_args.dart';
import 'package:grad/widgets/categories_single_product_page.dart';
import 'package:grad/widgets/category_tile_widget.dart';
import 'package:grad/widgets/product_loading_tile_widget.dart';
import 'package:grad/widgets/search_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  CategoriesBloc categoriesBloc = CategoriesBloc();
  String selectedCategory = 'electronics';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyTheme.mainColor,
        title: Text(
          "Browse Our Categories",
          style: Theme.of(context)
              .textTheme
              .headlineMedium
              ?.copyWith(color: Colors.white, fontSize: 25),
        ),
      ),
      body: BlocConsumer<CategoriesBloc, CategoriesState>(
        bloc: categoriesBloc,
        listenWhen: (previous, current) => current is CategoriesActionState,
        buildWhen: (previous, current) => current is! CategoriesActionState,
        listener: (context, state) {
          if (state is CategoriesNavigateToSingleProductState) {
            Navigator.pushNamed(context, CategoriesSingleProductPage.routeName,
                arguments: CategoriesToSingleProductArgs(
                    categoriesBloc: categoriesBloc,
                    categoryResponseModel: state.categoryResponseModel));
          } else if (state is CategoriesNavigateBackState) {
            Navigator.pop(context);
          } else if (state is CategoriesAddToCartState) {
            print("item added to cart");
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Item was added to cart",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
              backgroundColor: MyTheme.mainColor,
              duration: Duration(seconds: 1),
            ));
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                    color: MyTheme.mainColor,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Expanded(child: SearchBarWidget()),
                    PopupMenuButton(
                      position: PopupMenuPosition.under,
                      color: MyTheme.mainColor,
                      onSelected: (value) {
                        setState(() {
                          selectedCategory = value;
                        });
                      },
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15.0),
                        ),
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        child: const Icon(
                          IconlyBold.filter,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                      itemBuilder: (context) {
                        return [
                          const PopupMenuItem(
                              value: "electronics",
                              child: Text(
                                "Electronics",
                                style: TextStyle(color: Colors.white),
                              )),
                          const PopupMenuItem(
                              value: "jewelery",
                              child: Text(
                                "Jewelery",
                                style: TextStyle(color: Colors.white),
                              )),
                          const PopupMenuItem(
                              value: "men's clothing",
                              child: Text(
                                "Men's clothing",
                                style: TextStyle(color: Colors.white),
                              )),
                          const PopupMenuItem(
                              value: "women's clothing",
                              child: Text(
                                "Women's clothing",
                                style: TextStyle(color: Colors.white),
                              )),
                        ];
                      },
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: FutureBuilder(
                  future:
                      HomeCategoryRepo.getSpeceficCategory(selectedCategory),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                          child: Text(
                              "Error fetching data from server ${snapshot.error.toString()}"));
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 6 / 10,
                                crossAxisSpacing: 5,
                                mainAxisSpacing: 8),
                        itemBuilder: (context, index) {
                          return const ProductLoadingTileWidget();
                        },
                        itemCount: snapshot.data?.length,
                      );
                    } else if (snapshot.hasData) {
                      return GridView.builder(
                        padding: const EdgeInsets.all(10),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 6 / 9,
                                crossAxisSpacing: 0,
                                mainAxisSpacing: 0),
                        itemBuilder: (context, index) {
                          return CategoryTileWidget(
                            categoryResponseModel: snapshot.data![index],
                            categoriesBloc: categoriesBloc,
                            isHotDeal: false,
                          );
                        },
                        itemCount: snapshot.data!.length,
                      );
                    } else
                      return const SizedBox();
                  },
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
