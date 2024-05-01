// ignore_for_file: must_be_immutable

part of 'home_bloc.dart';

abstract class HomeEvent {}

class NavigateToCartEvent extends HomeEvent {}

class NavigateToWishlistEvent extends HomeEvent {}

class NavigateToSingleProductEvent extends HomeEvent {
  CategoryResponseModel? categoryResponseModel;
  HotDealModel? hotDealModel;
  NavigateToSingleProductEvent({this.hotDealModel, this.categoryResponseModel});
}

class NavigateToHotDealsEvent extends HomeEvent {}

class NavigateToRecommendedEvent extends HomeEvent {}

class GoBackEvent extends HomeEvent {}

class HomeAddToCartEvent extends HomeEvent {
  CategoryResponseModel categoryResponseModel;
  HomeAddToCartEvent({required this.categoryResponseModel});
}

class HomeAddToWishlistEvent extends HomeEvent {
  CategoryResponseModel? categoryResponseModel;
  HotDealModel? hotDealModel;
  HomeAddToWishlistEvent({this.categoryResponseModel, this.hotDealModel});
}

class HotDealsLoadedEvent extends HomeEvent {}
