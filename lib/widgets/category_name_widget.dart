import 'package:grad/theming/theme.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CategoryNameWidget extends StatelessWidget {
  String name;
  bool isSelected;
  CategoryNameWidget({super.key, required this.name, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(10),
        width: 120,
        height: 55,
        decoration: BoxDecoration(
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5), // Shadow color
                      spreadRadius: 2,
                      blurRadius: 3,
                      offset: const Offset(
                          0, 2), // changes the direction of the shadow
                    ),
                  ]
                : [],
            color: isSelected ? MyTheme.mainColor : MyTheme.lightGreyColor,
            border: isSelected ? null : Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(20)),
        child: Text(
          "$name  ",
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: isSelected
                  ? Colors.white
                  : Theme.of(context).textTheme.titleLarge?.color,
              fontWeight: FontWeight.w600),
          textAlign: TextAlign.center,
        ));
  }
}
