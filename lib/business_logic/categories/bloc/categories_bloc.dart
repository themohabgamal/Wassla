import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:grad/models/category_response_model.dart';
import 'package:grad/models/hot_deal_model.dart';
import 'package:grad/presentation/cart/cart_screen.dart';
import 'package:meta/meta.dart';

part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  CategoriesBloc() : super(CategoriesInitial()) {
    on<CategoriesNavigateToSingleProductPageEvent>(
        categoriesNavigateToSingleProductPageEvent);
    on<CategoriesNavigateBackEvent>(categoriesNavigateBackEvent);
    on<CategoriesAddToCartEvent>(categoriesAddToCartEvent);
  }

  FutureOr<void> categoriesNavigateToSingleProductPageEvent(
      CategoriesNavigateToSingleProductPageEvent event,
      Emitter<CategoriesState> emit) {
    emit(CategoriesNavigateToSingleProductState(
        categoryResponseModel: event.categoryResponseModel!));
  }

  FutureOr<void> categoriesNavigateBackEvent(
      CategoriesNavigateBackEvent event, Emitter<CategoriesState> emit) {
    emit(CategoriesNavigateBackState());
  }

  FutureOr<void> categoriesAddToCartEvent(
      CategoriesAddToCartEvent event, Emitter<CategoriesState> emit) {
    CartScreen.cartList.add(event.categoryResponseModel);

    emit(CategoriesAddToCartState());
  }
}
