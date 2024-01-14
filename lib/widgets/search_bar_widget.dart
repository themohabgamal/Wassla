import 'package:grad/theming/theme.dart';
import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        height: 60,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Row(
          children: [
            const Icon(Icons.search, size: 30, color: MyTheme.darkGreyColor),
            const SizedBox(width: 10),
            Text("Search",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(color: MyTheme.darkGreyColor, fontSize: 20)),
          ],
        ),
      ),
    );
  }
}
