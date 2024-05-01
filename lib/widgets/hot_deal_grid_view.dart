import 'package:flutter/material.dart';
import 'package:grad/business_logic/home/bloc/home_bloc.dart';
import 'package:grad/core/DI/dependency_injection.dart';
import 'package:grad/core/helpers/constants/fonts/font_helper.dart';
import 'package:grad/core/networking/firebase_helper.dart';
import 'package:grad/core/theming/theme.dart';
import 'package:grad/models/hot_deal_model.dart';
import 'package:grad/widgets/hot_deal_tile_widget.dart';
import 'package:grad/widgets/product_loading_tile_widget.dart';

class HotDealGridView extends StatefulWidget {
  final HomeBloc homeBloc;
  const HotDealGridView({
    super.key,
    required this.homeBloc,
  });

  @override
  HotDealGridViewState createState() => HotDealGridViewState();
}

class HotDealGridViewState extends State<HotDealGridView> {
  bool viewAll = false;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<HotDealModel>>(
      future: getIt<FirebaseHelper>().getHotDealsCollection(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(
                "Error fetching data from server ${snapshot.error.toString()}"),
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
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
                itemCount: viewAll ? snapshot.data!.length : 2,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 2 / 3,
                  crossAxisSpacing: 1,
                  mainAxisSpacing: 2,
                ),
                itemBuilder: (context, index) {
                  return HotDealTileWidget(
                    hotDealModel: snapshot.data![index],
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
