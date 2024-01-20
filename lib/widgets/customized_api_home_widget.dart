// ignore_for_file: must_be_immutable

import 'package:grad/business_logic/home/bloc/home_bloc.dart';
import 'package:grad/repositories/home_category_repo.dart';
import 'package:grad/widgets/category_tile_widget.dart';
import 'package:grad/widgets/product_loading_tile_widget.dart';
import 'package:flutter/material.dart';

class CustomizedApiHomeWidget extends StatelessWidget {
  String category;
  HomeBloc homeBloc;
  CustomizedApiHomeWidget(
      {super.key, required this.category, required this.homeBloc});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: HomeCategoryRepo.getSpeceficCategory(category),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
              child: Text(
                  "Error fetching data from server ${snapshot.error.toString()}"));
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const ProductLoadingTileWidget();
        } else if (snapshot.hasData) {
          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: snapshot.data!.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2 / 3,
                crossAxisSpacing: 2,
                mainAxisSpacing: 2),
            itemBuilder: (context, index) {
              return CategoryTileWidget(
                categoryResponseModel: snapshot.data![index],
                homeBloc: homeBloc,
                isHotDeal: false,
              );
            },
          );
        } else
          return const SizedBox();
      },
    );
  }
}
