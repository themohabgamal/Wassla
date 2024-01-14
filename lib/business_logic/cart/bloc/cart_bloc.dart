import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:grad/models/category_response_model.dart';
import 'package:grad/presentation/cart/cart_screen.dart';
import 'package:meta/meta.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<CartInitialEvent>(cartInitialEvent);
    on<CartLoadEvent>(cartLoadEvent);
    on<NavigateBackEvent>(goBackEvent);
    on<GoToCartSingleProductEvent>(goToCartSingleProductEvent);
    on<Reload>(reload);
  }

  FutureOr<void> cartInitialEvent(
      CartInitialEvent event, Emitter<CartState> emit) {
    emit(CartInitial());
  }

  FutureOr<void> cartLoadEvent(CartLoadEvent event, Emitter<CartState> emit) {
    emit(CartSuccessState(cartList: CartScreen.cartList));
  }

  FutureOr<void> goBackEvent(NavigateBackEvent event, Emitter<CartState> emit) {
    emit(NavigateBackState());
  }

  FutureOr<void> goToCartSingleProductEvent(
      GoToCartSingleProductEvent event, Emitter<CartState> emit) {
    emit(GoToCartSingleProductState(
        categoryResponseModel: event.categoryResponseModel));
  }

  FutureOr<void> reload(Reload event, Emitter<CartState> emit) {
    emit(calcNewBalance());
    emit(CartSuccessState(cartList: CartScreen.cartList));
  }
}
