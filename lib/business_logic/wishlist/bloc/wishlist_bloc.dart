import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad/models/category_response_model.dart';

part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  WishlistBloc() : super(WishlistInitial()) {
    on<WishlistNavigateBackEvent>(wishlistNavigateBackEvent);
    on<WishlistNavigateToSingleProductEvent>(
        wishlistNavigateToSingleProductEvent);
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
