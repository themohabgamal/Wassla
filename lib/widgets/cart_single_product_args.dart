import 'package:grad/business_logic/cart/bloc/bloc/cart_bloc.dart';
import 'package:grad/business_logic/wishlist/bloc/wishlist_bloc.dart';
import 'package:grad/models/category_response_model.dart';

class CartToSingleProductPageArgs {
  CartBloc? cartBloc;
  WishlistBloc? wishlistBloc;
  CategoryResponseModel categoryResponseModel;
  CartToSingleProductPageArgs(
      {this.cartBloc, this.wishlistBloc, required this.categoryResponseModel});
}
