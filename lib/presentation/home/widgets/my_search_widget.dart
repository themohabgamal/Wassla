import 'package:flutter/material.dart';
import 'package:grad/core/helpers/constants/fonts/font_helper.dart';
import 'package:grad/core/theming/theme.dart';
import 'package:grad/presentation/home/widgets/search_screen.dart';
import 'package:iconly/iconly.dart';

class MySearchWidget extends StatelessWidget {
  final BoxBorder? border;
  final Color? iconColor;
  const MySearchWidget({this.border, super.key, this.iconColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SearchScreen()),
        );
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: Colors.white,
            border:
                border ?? Border.all(color: Colors.transparent, width: 1.0)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: Row(
            children: [
              const SizedBox(width: 8.0),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    'Search for an item',
                    style: FontHelper.poppins18Regular()
                        .copyWith(color: Colors.grey),
                  ),
                ),
              ),
              Icon(
                IconlyLight.search,
                color: iconColor ?? MyTheme.mainColor,
                size: 35,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
