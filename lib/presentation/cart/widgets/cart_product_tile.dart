import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad/business_logic/cart/bloc/bloc/cart_bloc.dart';
import 'package:grad/core/DI/dependency_injection.dart';
import 'package:grad/presentation/cart/widgets/cart_product.dart';
import 'package:iconly/iconly.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CartProductTile extends StatelessWidget {
  final CartProduct cartProduct;

  const CartProductTile({super.key, required this.cartProduct});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CachedNetworkImage(
        imageUrl: cartProduct.product.imageUrl,
        progressIndicatorBuilder: (context, url, progress) =>
            LoadingAnimationWidget.hexagonDots(color: Colors.black, size: 30),
      ),
      title: Text(cartProduct.product.name),
      subtitle: Text('\$${cartProduct.product.price}'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.remove),
            onPressed: () {
              getIt<CartBloc>()
                  .updateQuantity(cartProduct, cartProduct.quantity - 1);
            },
          ),
          Text('${cartProduct.quantity}'),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              getIt<CartBloc>()
                  .updateQuantity(cartProduct, cartProduct.quantity + 1);
            },
          ),
          IconButton(
            icon: const Icon(IconlyBold.delete),
            onPressed: () {
              getIt<CartBloc>().removeFromCart(cartProduct);
            },
          ),
        ],
      ),
    );
  }
}
