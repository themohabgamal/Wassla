// ignore_for_file: must_be_immutable

part of 'wishlist_bloc.dart';

@immutable
abstract class WishlistEvent {}

class WishlistLoadEvent extends WishlistEvent {}

class WishlistRemoveItemEvent extends WishlistEvent {
  CategoryResponseModel categoryResponseModel;
  WishlistRemoveItemEvent({required this.categoryResponseModel});
}

class WishlistNavigateBackEvent extends WishlistEvent {}

class WishlistAddToCartEvent extends WishlistEvent {
  CategoryResponseModel categoryResponseModel;
  WishlistAddToCartEvent({required this.categoryResponseModel});
}

class WishlistNavigateToSingleProductEvent extends WishlistEvent {
  CategoryResponseModel categoryResponseModel;
  WishlistNavigateToSingleProductEvent({required this.categoryResponseModel});
}
