import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grad/business_logic/categories/bloc/categories_bloc.dart';
import 'package:grad/core/helpers/constants/fonts/font_helper.dart';
import 'package:grad/presentation/home/widgets/my_search_widget.dart';
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const SizedBox.shrink(),
        toolbarHeight: 60.h,
        backgroundColor: Colors.white,
        title: Text(
          "Store",
          style: FontHelper.poppins24Bold().copyWith(fontSize: 26.sp),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(
              IconlyLight.bag,
              color: Colors.black,
              size: 30,
            ),
            onPressed: () {},
          )
        ],
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
                    color: Colors.transparent,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15))),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child: MySearchWidget(
                          iconColor: Colors.black,
                          border: Border.all(color: Colors.black26),
                        )),
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
                              Radius.circular(2.0),
                            ),
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            child: const Icon(
                              IconlyBold.filter,
                              color: Colors.black,
                              size: 40,
                            ),
                          ),
                          itemBuilder: (context) {
                            return [
                              PopupMenuItem(
                                  value: "electronics",
                                  child: Text(
                                    "Electronics",
                                    style: FontHelper.poppins18Regular()
                                        .copyWith(color: Colors.white),
                                  )),
                              PopupMenuItem(
                                  value: "jewelery",
                                  child: Text(
                                    "Jewelery",
                                    style: FontHelper.poppins18Regular()
                                        .copyWith(color: Colors.white),
                                  )),
                              PopupMenuItem(
                                  value: "men's clothing",
                                  child: Text(
                                    "Men's clothing",
                                    style: FontHelper.poppins18Regular()
                                        .copyWith(color: Colors.white),
                                  )),
                              PopupMenuItem(
                                  value: "women's clothing",
                                  child: Text(
                                    "Women's clothing",
                                    style: FontHelper.poppins18Regular()
                                        .copyWith(color: Colors.white),
                                  )),
                            ];
                          },
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Featured Brands",
                            style: FontHelper.poppins20Bold(),
                          ),
                          TextButton(
                              onPressed: () {},
                              child: Text(
                                "View All",
                                style: FontHelper.poppins16Regular().copyWith(
                                    color:
                                        const Color.fromARGB(255, 50, 1, 213)),
                              ))
                        ]),
                    SizedBox(
                      height: 20.h,
                    ),
                    SizedBox(
                      height: 200,
                      child: GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: 4,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 8 / 4,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10),
                          itemBuilder: (context, index) {
                            return const BrandTab();
                          }),
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
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return const ProductLoadingTileWidget();
                        },
                        itemCount: snapshot.data?.length,
                      );
                    } else if (snapshot.hasData) {
                      return ListView.builder(
                        padding: const EdgeInsets.only(left: 20, bottom: 10),
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return CategoryTileWidget(
                            categoryResponseModel: snapshot.data![index],
                            categoriesBloc: categoriesBloc,
                            isHotDeal: false,
                          );
                        },
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

class BrandTab extends StatelessWidget {
  const BrandTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black26, width: 1),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(7),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 30,
              backgroundColor: Colors.transparent,
              backgroundImage: NetworkImage(
                  'https://pngimg.com/uploads/nike/nike_PNG18.png'),
            ),
            SizedBox(width: 12.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      'Nike',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 2.w,
                    ),
                    Image.asset(
                      'assets/icons/verified.png',
                      width: 15,
                    )
                  ],
                ),
                const SizedBox(height: 8),
                const Text(
                  '22 Products',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black45,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
