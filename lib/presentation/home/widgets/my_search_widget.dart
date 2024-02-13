import 'package:flutter/material.dart';
import 'package:grad/core/theming/theme.dart';
import 'package:iconly/iconly.dart';

class MySearchWidget extends StatelessWidget {
  final BoxBorder? border;
  final Color? iconColor;
  const MySearchWidget({this.border, super.key, this.iconColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Colors.white,
          border: border ?? Border.all(color: Colors.transparent, width: 1.0)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: Row(
          children: [
            const SizedBox(width: 8.0),
            const Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search for an item',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
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
    );
  }
}
