import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grad/business_logic/home/bloc/home_bloc.dart';
import 'package:grad/core/helpers/constants/fonts/font_helper.dart';
import 'package:grad/core/theming/theme.dart';

class FurnitureSection extends StatelessWidget {
  final HomeBloc? homeBloc;
  const FurnitureSection({super.key, this.homeBloc});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Furniture",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            TextButton(
              onPressed: () {
                homeBloc?.add(NavigateToHotDealsEvent());
              },
              //fake commit
              child: Text(
                "More",
                style: FontHelper.poppins16Bold()
                    .copyWith(color: MyTheme.mainColor),
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
                  "assets/images/fur.jpg",
                  height: 100.h,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
