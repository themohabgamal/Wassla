import 'package:flutter/material.dart';
import 'package:grad/core/helpers/constants/fonts/font_helper.dart';
import 'package:grad/widgets/customized_api_home_widget.dart';
import 'package:iconly/iconly.dart';
import 'package:grad/business_logic/home/bloc/home_bloc.dart';

class FurniturePage extends StatefulWidget {
  final HomeBloc homeBloc;
  const FurniturePage({super.key, required this.homeBloc});
  static const String routeName = 'furniture';
  @override
  State<FurniturePage> createState() => _HotDealsPageState();
}

class _HotDealsPageState extends State<FurniturePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(IconlyLight.arrow_left_2, color: Colors.black),
          onPressed: () {
            widget.homeBloc.add(GoBackEvent());
          },
        ),
        centerTitle: true,
        title: Text(
          "Furniture",
          style: FontHelper.poppins24Bold(),
        ),
      ),
      body: SizedBox(
        child: CustomizedApiHomeWidget(
          homeBloc: widget.homeBloc,
          category: "Furniture",
        ),
      ),
    );
  }
}
