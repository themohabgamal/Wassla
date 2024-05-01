import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad/presentation/cart/widgets/cart_product.dart';
import 'package:grad/presentation/cart/widgets/product.dart';

class CartBloc extends Cubit<List<CartProduct>> {
  CartBloc(String userId) : super([]) {
    // Fetch initial cart data from Firestore
    _fetchInitialCartData(userId);
  }

  // Method to update the user ID and fetch the cart data
  void updateUserAndFetchCart(String? userId) {
    _fetchInitialCartData(userId);
  }

  void _fetchInitialCartData(String? userId) async {
    try {
      final cartDoc = await FirebaseFirestore.instance
          .collection('carts')
          .doc(userId)
          .get();

      if (cartDoc.exists) {
        final cartData = cartDoc.data();
        if (cartData != null && cartData['products'] != null) {
          final List<CartProduct> initialCartProducts =
              (cartData['products'] as List).map((productData) {
            return CartProduct(
              product: Product(
                imageUrl: productData['imageUrl'],
                name: productData['name'],
                price: productData['price'],
              ),
              quantity: productData['quantity'],
            );
          }).toList();

          emit(initialCartProducts);
        }
      } else {
        // If the cart document doesn't exist, initialize an empty cart
        emit([]);
      }
    } catch (error) {
      // Handle error fetching cart data from Firestore
    }
  }

  // ... (rest of your existing methods remain the same)

  void clearCart() {
    emit([]); // Clear the cart by emitting an empty list of CartProduct
    _updateFirestoreCart(); // Update Firestore to reflect the cleared cart
  }

  void addToCart(CartProduct cartProduct) {
    emit([...state, cartProduct]);
    _updateFirestoreCart();
  }

  void removeFromCart(CartProduct cartProduct) {
    emit(state.where((item) => item.product != cartProduct.product).toList());
    _updateFirestoreCart();
  }

  void updateQuantity(CartProduct cartProduct, int newQuantity) {
    emit(state.map((item) {
      if (item.product == cartProduct.product) {
        return CartProduct(product: item.product, quantity: newQuantity);
      }
      return item;
    }).toList());
    _updateFirestoreCart();
  }

  void _updateFirestoreCart() {
    // Update Firestore collection with the current state of the cart
    FirebaseFirestore.instance
        .collection('carts')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({
      'products': state.map((cartProduct) {
        return {
          'imageUrl': cartProduct.product.imageUrl,
          'name': cartProduct.product.name,
          'price': cartProduct.product.price,
          'quantity': cartProduct.quantity,
        };
      }).toList(),
    });
  }
}
