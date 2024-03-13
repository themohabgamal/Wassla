import 'package:grad/presentation/cart/widgets/product.dart';

abstract class CartEvent {}

class AddToCartEvent extends CartEvent {
  final Product product;
  AddToCartEvent(this.product);
}

class UpdateProductQuantityEvent extends CartEvent {
  final int productId; // Make sure this field is defined

  // Other fields as needed
  final int quantity;

  UpdateProductQuantityEvent({
    required this.productId,
    required this.quantity,
  });

  @override
  List<Object> get props => [productId, quantity];
}

class RemoveFromCartEvent extends CartEvent {
  final Product product;

  RemoveFromCartEvent(this.product);
}
