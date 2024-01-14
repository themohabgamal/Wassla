// ignore_for_file: must_be_immutable

part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

abstract class HomeActionState extends HomeState {}

class HomeInitial extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeLoadedState extends HomeState {}

class HomeErrorState extends HomeState {}

class NavigateToCartState extends HomeActionState {}

class NavigateToWishlistState extends HomeActionState {}

class NavigateToHotDealsState extends HomeActionState {}

class AddToCartState extends HomeActionState {}

class AddToWishlistState extends HomeActionState {}

class GoBackState extends HomeActionState {}

class NavigateToSingleProductState extends HomeActionState {
  CategoryResponseModel categoryResponseModel;
  NavigateToSingleProductState({required this.categoryResponseModel});
}

class HotDealsLoadingState extends HomeState {}

class HotDealsLoadedState extends HomeState {
  List<CategoryResponseModel> list;
  HotDealsLoadedState({required this.list});
}
