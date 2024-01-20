import 'package:grad/core/theming/theme.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ProductLoadingTileWidget extends StatelessWidget {
  const ProductLoadingTileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2 / 3,
          mainAxisSpacing: 2,
          crossAxisSpacing: 2),
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.all(10),
          width: 180,
          height: 250,
          decoration: BoxDecoration(
              color: Colors.grey.withAlpha(30),
              borderRadius: BorderRadius.circular(15)),
          child: Center(
            child: LoadingAnimationWidget.threeArchedCircle(
              color: MyTheme.mainColor,
              size: 50,
            ),
          ),
        );
      },
    ));
  }
}
