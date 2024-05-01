// ignore_for_file: must_be_immutable
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grad/business_logic/wishlist/bloc/wishlist_bloc.dart';
import 'package:grad/core/helpers/constants/fonts/font_helper.dart';
import 'package:grad/models/category_response_model.dart';
import 'package:flutter/material.dart';

class WishlistTileWidget extends StatefulWidget {
  CategoryResponseModel categoryResponseModel;
  WishlistBloc wishlistBloc;

  WishlistTileWidget(
      {super.key,
      required this.categoryResponseModel,
      required this.wishlistBloc});

  @override
  State<WishlistTileWidget> createState() => _WishlistTileWidget();
}

class _WishlistTileWidget extends State<WishlistTileWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: 220,
      height: 100.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), color: Colors.grey.shade200),
      child: Row(
        children: [
          CachedNetworkImage(
            imageUrl: "${widget.categoryResponseModel.image}",
            width: 80,
            fit: BoxFit.contain,
          ),
          const SizedBox(width: 10),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 10),
              Text(
                "${categoryTitleBuilder(widget.categoryResponseModel.title)}",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: FontHelper.poppins16Bold().copyWith(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).textTheme.titleLarge?.color),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "\$ ${widget.categoryResponseModel.price.toString()}",
                      style: FontHelper.poppins20Regular(),
                    ),
                  ],
                ),
              ),
            ],
          ))
        ],
      ),
    );
  }

  String? categoryTitleBuilder(String? title) {
    if (title!.length > 30) {
      return title.substring(0, 30);
    } else {
      return title;
    }
  }
}
