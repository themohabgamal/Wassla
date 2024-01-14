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
    return Column(
      children: [
        SizedBox(
          height: 260,
          width: double.infinity,
          child: FutureBuilder(
            future: HomeCategoryRepo.getSpeceficCategory(category),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                    child: Text(
                        "Error fetching data from server ${snapshot.error.toString()}"));
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const ProductLoadingTileWidget();
              } else if (snapshot.hasData) {
                return ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return CategoryTileWidget(
                        homeBloc: homeBloc,
                        categoryResponseModel: snapshot.data![index],
                        isHotDeal: false,
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(width: 10);
                    },
                    itemCount: snapshot.data!.length);
              } else
                return const SizedBox();
            },
          ),
        )
      ],
    );
  }
}
