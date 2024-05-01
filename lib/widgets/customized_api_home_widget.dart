import 'package:flutter/material.dart';
import 'package:grad/business_logic/home/bloc/home_bloc.dart';
import 'package:grad/core/DI/dependency_injection.dart';
import 'package:grad/core/helpers/constants/fonts/font_helper.dart';
import 'package:grad/core/networking/firebase_helper.dart';
import 'package:grad/core/theming/theme.dart';
import 'package:grad/models/category_response_model.dart';
import 'package:grad/widgets/category_tile_widget.dart';
import 'package:grad/widgets/product_loading_tile_widget.dart';

class CustomizedApiHomeWidget extends StatefulWidget {
  final String category;
  final HomeBloc homeBloc;
  const CustomizedApiHomeWidget({
    super.key,
    required this.category,
    required this.homeBloc,
  });

  @override
  CustomizedApiHomeWidgetState createState() => CustomizedApiHomeWidgetState();
}

class CustomizedApiHomeWidgetState extends State<CustomizedApiHomeWidget> {
  bool viewAll = false;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CategoryResponseModel>>(
      future: getIt<FirebaseHelper>().getCategoryProducts(widget.category),
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
        } else if (snapshot.hasError) {
          return Center(
            child: Text(
                "Error fetching data from server ${snapshot.error.toString()}"),
          );
        } else if (snapshot.hasData) {
          if (snapshot.data!.isEmpty) {
            return Center(
              child: Text("No products found for ${widget.category}"),
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
                    child: Text(viewAll ? 'View Less' : 'View All',
                        style: FontHelper.poppins16Bold()
                            .copyWith(color: MyTheme.mainColor)),
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
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
          return const SizedBox();
        }
      },
    );
  }
}
