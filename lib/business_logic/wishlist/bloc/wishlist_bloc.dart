import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:grad/models/category_response_model.dart';
import 'package:grad/presentation/cart/cart_screen.dart';
import 'package:grad/presentation/wishlist/wish_list_screen.dart';
import 'package:meta/meta.dart';

part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  WishlistBloc() : super(WishlistInitial()) {
    on<WishlistRemoveItemEvent>(wishlistRemoveItemEvent);
    on<WishlistLoadEvent>(wishlistLoadEvent);
    on<WishlistNavigateBackEvent>(wishlistNavigateBackEvent);
    on<WishlistNavigateToSingleProductEvent>(
        wishlistNavigateToSingleProductEvent);
  }

  FutureOr<void> wishlistRemoveItemEvent(
      WishlistRemoveItemEvent event, Emitter<WishlistState> emit) {
    WishListScreen.wishListList.remove(event.categoryResponseModel);
    emit(WishlistLoadState(list: WishListScreen.wishListList));
  }

  FutureOr<void> wishlistLoadEvent(
      WishlistLoadEvent event, Emitter<WishlistState> emit) {
    emit(WishlistLoadState(list: WishListScreen.wishListList));
  }

  FutureOr<void> wishlistNavigateBackEvent(
      WishlistNavigateBackEvent event, Emitter<WishlistState> emit) {
    emit(WishlistNavigateBackState());
  }

  FutureOr<void> wishlistNavigateToSingleProductEvent(
      WishlistNavigateToSingleProductEvent event, Emitter<WishlistState> emit) {
    emit(WishlistNavigateToSingleProductState(
        categoryResponseModel: event.categoryResponseModel));
  }
}
