// ignore_for_file: must_be_immutable

part of 'categories_bloc.dart';

abstract class CategoriesEvent {}

class CartInitialEvent extends CategoriesEvent {}

class CategoriesNavigateToSingleProductPageEvent extends CategoriesEvent {
  CategoryResponseModel? categoryResponseModel;
  HotDealModel? hotDealModel;
  CategoriesNavigateToSingleProductPageEvent(
      {this.hotDealModel, this.categoryResponseModel});
}

class CategoriesAddToCartEvent extends CategoriesEvent {
  CategoryResponseModel categoryResponseModel;
  CategoriesAddToCartEvent({required this.categoryResponseModel});
}

class CategoriesAddToWishlistEvent extends CategoriesEvent {
  CategoryResponseModel? categoryResponseModel;
  HotDealModel? hotDealModel;
  CategoriesAddToWishlistEvent({this.categoryResponseModel, this.hotDealModel});
}

class CategoriesNavigateBackEvent extends CategoriesEvent {}
