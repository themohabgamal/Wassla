import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grad/business_logic/cart/bloc/bloc/cart_bloc.dart';
import 'package:grad/core/DI/dependency_injection.dart';
import 'package:grad/core/helpers/constants/fonts/font_helper.dart';
import 'package:grad/core/theming/theme.dart';
import 'package:grad/core/widgets/my_button.dart';
import 'package:grad/presentation/cart/widgets/cart_product.dart';
import 'package:grad/presentation/cart/widgets/cart_product_tile.dart';
import 'package:grad/presentation/settings/address/my_addresses_screen.dart';
import 'package:lottie/lottie.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cart',
          style: FontHelper.poppins24Bold(),
        ),
      ),
      body: BlocBuilder<CartBloc, List<CartProduct>>(
        bloc: getIt<CartBloc>(),
        builder: (context, cartProducts) {
          if (cartProducts.isEmpty) {
            return _buildEmptyCartMessage(context);
          } else {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartProducts.length,
                    itemBuilder: (context, index) {
                      final cartProduct = cartProducts[index];
                      return CartProductTile(cartProduct: cartProduct);
                    },
                  ),
                ),
                const Divider(),
                _buildTotalPriceAndProceedButton(context, cartProducts),
              ],
            );
          }
        },
      ),
    );
  }

  Widget _buildEmptyCartMessage(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LottieBuilder.asset('assets/animations/cart.json'),
          SizedBox(height: 20.h),
          Text(
            'Your cart is empty',
            style: FontHelper.poppins14Regular(),
          ),
          const SizedBox(height: 10),
          Text(
            'Start shopping to fill your cart',
            style: FontHelper.poppins14Regular(),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildTotalPriceAndProceedButton(
    BuildContext context,
    List<CartProduct> cartProducts,
  ) {
    // Calculate total price
    num totalPrice = 0;
    for (var cartProduct in cartProducts) {
      totalPrice += cartProduct.product.price * cartProduct.quantity;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 25),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total:',
                style: FontHelper.poppins18Bold(),
              ),
              Text(
                '\$$totalPrice', // Display total price here
                style: FontHelper.poppins18Bold(),
              ),
            ],
          ),
          SizedBox(height: 25.h),
          MyButton(
            text: 'Continue',
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return MyAddressesScreen(
                    totalPrice: totalPrice,
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
