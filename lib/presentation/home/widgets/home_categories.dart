import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shimmer/shimmer.dart'; // Import the shimmer package
import 'package:grad/models/category/category_model.dart';

import '../../../core/helpers/constants/fonts/font_helper.dart';
import '../../../widgets/category_name_widget.dart';
import 'category_products_screen.dart';

class HomeCategories extends StatelessWidget {
  const HomeCategories({
    super.key,
    required this.categories,
    required this.current,
  });

  final List<CategoryModel> categories;
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
          child: categories.isEmpty
              ? Center(
                  child: SpinKitRing(
                  color: Colors.white,
                  size: 30.sp,
                ))
              : ListView.separated(
                  physics: const ClampingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return CategoryProductsScreen(
                            categoryTitle: categories[index].title,
                          );
                        }));
                      },
                      child: CategoryNameWidget(
                        image: categories[index].image,
                        name: categories[index].title,
                        isSelected: index == current ? true : false,
                      ),
                    );
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 10),
                  itemCount: categories.length,
                ),
        ),
        SizedBox(
          height: 10.h,
        )
      ],
    );
  }
}

// Shimmer effect widget for HomeCategories
class ShimmerHomeCategories extends StatelessWidget {
  const ShimmerHomeCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.white,
      child: ListView.separated(
        physics: const ClampingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return const CategoryNameWidgetShimmer(); // Use a shimmer version of your CategoryNameWidget
        },
        separatorBuilder: (context, index) => const SizedBox(width: 10),
        itemCount: 8, // You can adjust this based on your design
      ),
    );
  }
}

// Shimmer effect widget for each item in the list
class CategoryNameWidgetShimmer extends StatelessWidget {
  const CategoryNameWidgetShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
      radius: 30,
    );
  }
}
