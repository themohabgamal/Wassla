import 'package:grad/business_logic/categories/bloc/categories_bloc.dart';
import 'package:grad/models/category_response_model.dart';

class CategoriesToSingleProductArgs {
  CategoryResponseModel categoryResponseModel;
  CategoriesBloc categoriesBloc;
  CategoriesToSingleProductArgs(
      {required this.categoriesBloc, required this.categoryResponseModel});
}
