import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class HeaderWidget extends StatelessWidget {
  final String firstName;
  final String lastName;
  const HeaderWidget({
    super.key,
    required this.firstName,
    required this.lastName,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Good day for shopping",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.white)),
            Text(
                firstName == ''
                    ? ""
                    : "${firstName[0].toUpperCase() + firstName.substring(1)} $lastName",
                style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: Colors.white)),
          ],
        ),
      ],
    );
  }
}
