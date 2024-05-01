// ignore_for_file: must_be_immutable

part of 'wishlist_bloc.dart';

abstract class WishlistState {}

abstract class WishlistActionState extends WishlistState {}

class WishlistInitial extends WishlistState {}

class WishlistLoadState extends WishlistState {
  List<CategoryResponseModel> list;
  WishlistLoadState({required this.list});
}

class WishlistRemoveItemState extends WishlistState {}

class WishlistNavigateBackState extends WishlistActionState {}

class WishlistAddToCartState extends WishlistActionState {}

class WishlistNavigateToSingleProductState extends WishlistActionState {
  CategoryResponseModel categoryResponseModel;
  WishlistNavigateToSingleProductState({required this.categoryResponseModel});
}
