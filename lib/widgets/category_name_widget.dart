import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:grad/core/helpers/constants/fonts/font_helper.dart';

// ignore: must_be_immutable
class CategoryNameWidget extends StatelessWidget {
  String name;
  String image;
  bool isSelected;
  CategoryNameWidget(
      {super.key,
      required this.image,
      required this.name,
      required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CachedNetworkImage(
              imageUrl: image,
              fit: BoxFit.cover,
              width: 40.w,
            ),
          ),
        ),
        SizedBox(
          height: 2.h,
        ),
        SizedBox(
          width: 80,
          child: Text(
            "$name  ",
            style: FontHelper.poppins12Regular().copyWith(color: Colors.white),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        )
      ],
    );
  }
}
