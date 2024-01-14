// ignore_for_file: must_be_immutable

part of 'cart_bloc.dart';

@immutable
abstract class CartEvent {}

class CartInitialEvent extends CartEvent {}

class CartLoadEvent extends CartEvent {}

class NavigateBackEvent extends CartEvent {}

class CartNavigateToSingleProductEvent extends CartEvent {
  CategoryResponseModel categoryResponseModel;
  CartNavigateToSingleProductEvent({required this.categoryResponseModel});
}

class GoToCartSingleProductEvent extends CartEvent {
  CategoryResponseModel categoryResponseModel;
  GoToCartSingleProductEvent({required this.categoryResponseModel});
}

class GetNewSubTotalEvent extends CartEvent {
  num quantity;
  GetNewSubTotalEvent({required this.quantity});
}

class Reload extends CartEvent {}
