import 'package:flutter/material.dart';
import 'package:grad/core/helpers/constants/fonts/font_helper.dart';
import 'package:grad/core/networking/api_helper.dart';
import 'package:grad/core/theming/theme.dart';
import 'package:grad/models/category_response_model.dart';
import 'package:grad/widgets/category_tile_widget.dart';
import 'package:grad/widgets/product_loading_tile_widget.dart';
import 'package:iconly/iconly.dart';
import 'package:grad/business_logic/home/bloc/home_bloc.dart';
import 'package:lottie/lottie.dart';

class RecommendedPage extends StatefulWidget {
  final HomeBloc homeBloc;
  const RecommendedPage({super.key, required this.homeBloc});
  static const String routeName = 'recommended';
  @override
  State<RecommendedPage> createState() => _RecommendedPageState();
}

class _RecommendedPageState extends State<RecommendedPage> {
  bool viewAll = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(IconlyLight.arrow_left_2, color: Colors.black),
          onPressed: () {
            widget.homeBloc.add(GoBackEvent());
          },
        ),
        centerTitle: true,
        title: Text(
          "Recommended",
          style: FontHelper.poppins24Bold(),
        ),
      ),
      body: SizedBox(
        child: FutureBuilder<List<CategoryResponseModel>?>(
          future: ApiHelper().getRecommendedProducts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: viewAll ? snapshot.data!.length : 2,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 2 / 3,
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 2,
                ),
                itemBuilder: (context, index) {
                  return const ProductLoadingTileWidget();
                },
              );
            } else if (snapshot.hasData) {
              if (snapshot.data!.isEmpty) {
                return const Center(
                  child: Text(
                    "No Recommended Products Found. Try Liking some products ;)",
                    style: TextStyle(color: Colors.grey),
                  ),
                );
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (snapshot.data!.length > 2)
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            viewAll = !viewAll;
                          });
                        },
                        child: Text(
                          viewAll ? 'View Less' : 'View All',
                          style: FontHelper.poppins16Bold().copyWith(
                            color: MyTheme.mainColor,
                          ),
                        ),
                      ),
                    ),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: viewAll
                        ? snapshot.data!.length
                        : snapshot.hasData && snapshot.data!.length > 1
                            ? 2
                            : 1,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 2 / 3,
                      crossAxisSpacing: 1,
                      mainAxisSpacing: 2,
                    ),
                    itemBuilder: (context, index) {
                      return CategoryTileWidget(
                        categoryResponseModel: snapshot.data![index],
                        homeBloc: widget.homeBloc,
                      );
                    },
                  ),
                ],
              );
            } else {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LottieBuilder.asset('assets/animations/sad.json'),
                    Text(
                      "No Recommended Products Found. Try Liking some products",
                      textAlign: TextAlign.center,
                      style: FontHelper.poppins14Regular(),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
