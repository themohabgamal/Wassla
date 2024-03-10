// ignore_for_file: must_be_immutable

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grad/business_logic/home/bloc/home_bloc.dart';
import 'package:grad/core/DI/dependency_injection.dart';
import 'package:grad/core/networking/firebase_helper.dart';
import 'package:grad/models/category_response_model.dart';
import 'package:grad/widgets/category_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:grad/widgets/product_loading_tile_widget.dart';

class CategoryListView extends StatelessWidget {
  String category;
  HomeBloc homeBloc;
  CategoryListView({super.key, required this.category, required this.homeBloc});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CategoryResponseModel>>(
      future: getIt<FirebaseHelper>().getCategoryProducts(category),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
              child: Text(
                  "Error fetching data from server ${snapshot.error.toString()}"));
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: 3,
              itemBuilder: (context, index) {
                return const ProductLoadingTileWidget();
              });
        } else if (snapshot.hasData) {
          return ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return CategoryTileWidget(
                  categoryResponseModel: snapshot.data![index],
                  homeBloc: homeBloc,
                );
              });
        } else {
          print("wewwewwaa");
          return const SizedBox();
        }
      },
    );
  }
}
