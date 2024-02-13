// ignore_for_file: must_be_immutable

import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grad/business_logic/categories/bloc/categories_bloc.dart';
import 'package:grad/core/helpers/constants/fonts/font_helper.dart';
import 'package:grad/models/category_response_model.dart';
import 'package:grad/core/theming/theme.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import '../business_logic/home/bloc/home_bloc.dart';

class CategoryTileWidget extends StatelessWidget {
  CategoryResponseModel categoryResponseModel;
  HomeBloc? homeBloc;
  CategoriesBloc? categoriesBloc;
  bool isHotDeal;
  CategoryTileWidget(
      {super.key,
      required this.categoryResponseModel,
      this.homeBloc,
      this.categoriesBloc,
      required this.isHotDeal});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (homeBloc != null) {
          homeBloc?.add(NavigateToSingleProductEvent(
              categoryResponseModel: categoryResponseModel));
        } else {
          categoriesBloc?.add(CategoriesNavigateToSingleProductPageEvent(
              categoryResponseModel: categoryResponseModel));
        }
      },
      child: Container(
        padding: const EdgeInsets.all(1),
        margin: const EdgeInsets.all(7),
        width: 200,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFb4b4b4).withOpacity(0.8),
                offset: const Offset(4, 4),
                blurRadius: 10,
                spreadRadius: 4,
              ),
            ],
            borderRadius: BorderRadius.circular(15),
            color: Theme.of(context).canvasColor),
        child: Column(
          children: [
            Expanded(
                flex: 2,
                child: Image.network(
                  "${categoryResponseModel.image}",
                  width: 150,
                  fit: BoxFit.contain,
                )),
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
                            isHotDeal ? "HOT DEAL" : "BEST SELLER",
                            style: FontHelper.poppins16Bold().copyWith(
                                fontSize: 15,
                                color:
                                    isHotDeal ? Colors.red : MyTheme.mainColor),
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            "${categoryTitleBuilder(categoryResponseModel.title)}",
                            style: FontHelper.poppins16Regular(),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          isHotDeal
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "\$ ${categoryResponseModel.price}",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w300,
                                          fontSize: 18,
                                          decorationColor: Colors.red,
                                          decorationStyle:
                                              TextDecorationStyle.solid,
                                          decorationThickness: 2,
                                          decoration:
                                              TextDecoration.lineThrough),
                                    ),
                                    Text(
                                      "\$ ${categoryResponseModel.price}",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18),
                                    )
                                  ],
                                )
                              : Text(
                                  "\$ ${categoryResponseModel.price.toString().length > 3 ? categoryResponseModel.price.toString().substring(0, 3) : categoryResponseModel.price}",
                                  style: FontHelper.poppins20Bold(),
                                ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    if (homeBloc != null) {
                                      homeBloc?.add(HomeAddToWishlistEvent(
                                          categoryResponseModel:
                                              categoryResponseModel));
                                    } else {
                                      categoriesBloc?.add(
                                          CategoriesAddToWishlistEvent(
                                              categoryResponseModel:
                                                  categoryResponseModel));
                                    }
                                  },
                                  icon: Icon(
                                    IconlyLight.heart,
                                    color: Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.color,
                                  )),
                              IconButton(
                                  onPressed: () {
                                    if (homeBloc != null) {
                                      homeBloc?.add(HomeAddToCartEvent(
                                          categoryResponseModel:
                                              categoryResponseModel));
                                    } else {
                                      categoriesBloc?.add(
                                          CategoriesAddToCartEvent(
                                              categoryResponseModel:
                                                  categoryResponseModel));
                                    }
                                  },
                                  icon: Container(
                                    width: 40,
                                    height: 60,
                                    decoration: const BoxDecoration(
                                        color: MyTheme.mainColor,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            bottomRight: Radius.circular(10))),
                                    child: const Icon(Icons.add,
                                        size: 25, color: Colors.white),
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }

  String? categoryTitleBuilder(String? title) {
    if (title!.length > 25) {
      return "${title.substring(0, 25)}...";
    } else {
      return title;
    }
  }
}
