// ignore_for_file: must_be_immutable

part of 'categories_bloc.dart';

@immutable
abstract class CategoriesEvent {}

class CartInitialEvent extends CategoriesEvent {}

class CategoriesNavigateToSingleProductPageEvent extends CategoriesEvent {
  CategoryResponseModel categoryResponseModel;
  CategoriesNavigateToSingleProductPageEvent(
      {required this.categoryResponseModel});
}

class CategoriesAddToCartEvent extends CategoriesEvent {
  CategoryResponseModel categoryResponseModel;
  CategoriesAddToCartEvent({required this.categoryResponseModel});
}

class CategoriesAddToWishlistEvent extends CategoriesEvent {
  CategoryResponseModel categoryResponseModel;
  CategoriesAddToWishlistEvent({required this.categoryResponseModel});
}

class CategoriesNavigateBackEvent extends CategoriesEvent {}
