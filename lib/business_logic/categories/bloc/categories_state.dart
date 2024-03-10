// ignore_for_file: must_be_immutable

part of 'categories_bloc.dart';

@immutable
abstract class CategoriesState {}

abstract class CategoriesActionState extends CategoriesState {}

class CategoriesInitial extends CategoriesState {}

class CategoriesLoadedState extends CategoriesState {}

class CategoriesLoadingState extends CategoriesState {}

class CategoriesErrorState extends CategoriesState {}

class CategoriesNavigateToSingleProductState extends CategoriesActionState {
  CategoryResponseModel? categoryResponseModel;
  HotDealModel? hotDealModel;
  CategoriesNavigateToSingleProductState(
      {this.hotDealModel, this.categoryResponseModel});
}

class CategoriesAddToCartState extends CategoriesActionState {}

class CategoriesAddToWishlistState extends CategoriesActionState {}

class CategoriesNavigateBackState extends CategoriesActionState {}
