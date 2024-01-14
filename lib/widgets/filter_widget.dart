import 'package:flutter/material.dart';

class FilterWidget extends StatelessWidget {
  const FilterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(3),
      margin: const EdgeInsets.only(left: 7),
      width: 55,
      height: 55,
      decoration: BoxDecoration(
          boxShadow: [],
          borderRadius: BorderRadius.circular(50),
          color: Colors.indigo),
      child: IconButton(
        icon: Image.asset("assets/images/filter.png", color: Colors.white),
        onPressed: () {},
      ),
    );
  }
}
