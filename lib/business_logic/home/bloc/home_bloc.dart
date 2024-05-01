import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad/models/category_response_model.dart';
import 'package:grad/models/hot_deal_model.dart';
import 'package:grad/repositories/home_category_repo.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<NavigateToCartEvent>(navigateToCartEvent);
    on<NavigateToSingleProductEvent>(navigateToSingleProductEvent);
    on<NavigateToHotDealsEvent>(navigateToHotDealsEvent);
    on<GoBackEvent>(goBackEvent);
    on<HotDealsLoadedEvent>(hotDealsLoadedEvent);
    on<NavigateToWishlistEvent>(navigateToWishlistEvent);
    on<HomeAddToWishlistEvent>(addToWishlistEvent);
    on<HomeAddToCartEvent>(addToCartEvent);
    on<NavigateToRecommendedEvent>(navigateToRecommendedEvent);
  }

  FutureOr<void> navigateToCartEvent(
      NavigateToCartEvent event, Emitter<HomeState> emit) {
    emit(NavigateToCartState());
  }

  FutureOr<void> navigateToSingleProductEvent(
      NavigateToSingleProductEvent event, Emitter<HomeState> emit) {
    emit(NavigateToSingleProductState(
        categoryResponseModel: event.categoryResponseModel!));
  }

  FutureOr<void> navigateToHotDealsEvent(
      NavigateToHotDealsEvent event, Emitter<HomeState> emit) {
    emit(NavigateToHotDealsState());
  }

  FutureOr<void> goBackEvent(GoBackEvent event, Emitter<HomeState> emit) {
    emit(GoBackState());
  }

  FutureOr<void> hotDealsLoadedEvent(
      HotDealsLoadedEvent event, Emitter<HomeState> emit) async {
    emit(HotDealsLoadingState());
    var response = await HomeCategoryRepo().getAllProcuts();
    emit(HotDealsLoadedState(list: response!));
  }

  FutureOr<void> navigateToWishlistEvent(
      NavigateToWishlistEvent event, Emitter<HomeState> emit) {
    emit(NavigateToWishlistState());
  }

  Future<void> addToWishlistEvent(
      HomeAddToWishlistEvent event, Emitter<HomeState> emit) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final userId = user.uid;
        final product = event.hotDealModel == null
            ? event.categoryResponseModel!.toJson()
            : event.hotDealModel!.toJson();

        // Store the wishlist item in Firestore
        await FirebaseFirestore.instance
            .collection('wishlist')
            .doc(userId)
            .collection('items')
            .add(product);

        // Emit the state to indicate success
        emit(AddToWishlistState());
      } else {
        throw Exception('User is not logged in');
      }
    } catch (error) {
      // Handle the error
      print('Error adding to wishlist: $error');
      // Emit an error state if needed
    }
  }

  FutureOr<void> navigateToRecommendedEvent(
      NavigateToRecommendedEvent event, Emitter<HomeState> emit) {
    emit(NavigateToRecommendedState());
  }

  FutureOr<void> addToCartEvent(
      HomeAddToCartEvent event, Emitter<HomeState> emit) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final userId = user.uid;
        final product = event.categoryResponseModel.toJson();
        FirebaseFirestore.instance
            .collection('carts')
            .doc(userId)
            .collection('products')
            .add(product);
        emit(AddToCartState());
      } else {
        throw Exception('User is not logged in');
      }
    } catch (error) {
      // Handle the error
      print('Error adding to wishlist: $error');
      // Emit an error state if needed
    }
  }
}
