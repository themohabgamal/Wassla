import 'package:flutter/material.dart';
import 'package:grad/business_logic/home/bloc/home_bloc.dart';
import 'package:grad/core/DI/dependency_injection.dart';
import 'package:grad/core/helpers/constants/fonts/font_helper.dart';
import 'package:grad/widgets/customized_api_home_widget.dart';

class CategoryProductsScreen extends StatelessWidget {
  final String categoryTitle;
  const CategoryProductsScreen({super.key, required this.categoryTitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          categoryTitle,
          style: FontHelper.poppins24Bold(),
        ),
        centerTitle: true,
      ),
      body: SizedBox(
          width: double.infinity,
          child: CustomizedApiHomeWidget(
              homeBloc: getIt<HomeBloc>(), category: categoryTitle)),
    );
  }
}
