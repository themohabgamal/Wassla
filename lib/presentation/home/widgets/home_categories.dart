import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/helpers/constants/fonts/font_helper.dart';
import '../../../widgets/category_name_widget.dart';

class HomeCategories extends StatelessWidget {
  const HomeCategories({
    super.key,
    required this.categoriesIcons,
    required this.categories,
    required this.current,
  });

  final List<String> categoriesIcons;
  final List<String> categories;
  final int current;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.bottomLeft,
          child: Text(
            "Popular Categories",
            style: FontHelper.poppins18Regular()
                .copyWith(fontWeight: FontWeight.w600, color: Colors.white),
          ),
        ),
        SizedBox(
          height: 15.h,
        ),
        SizedBox(
          height: 90,
          child: ListView.separated(
            physics: const ClampingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {},
                child: CategoryNameWidget(
                    image: categoriesIcons[index],
                    name: categories[index],
                    isSelected: index == current ? true : false),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(width: 10),
            itemCount: 5,
          ),
        ),
        SizedBox(
          height: 10.h,
        )
      ],
    );
  }
}
