// ignore_for_file: must_be_immutable

part of 'cart_bloc.dart';

@immutable
abstract class CartState {}

abstract class CartActionState extends CartState {}

class CartInitial extends CartState {}

class CartSuccessState extends CartState {
  List<CategoryResponseModel> cartList;
  CartSuccessState({required this.cartList});
}

class NavigateBackState extends CartActionState {}

class GoToCartSingleProductState extends CartActionState {
  CategoryResponseModel categoryResponseModel;
  GoToCartSingleProductState({required this.categoryResponseModel});
}

class GetNewSubTotalState extends CartActionState {
  num quantity;
  GetNewSubTotalState({required this.quantity});
}

class calcNewBalance extends CartActionState {}
