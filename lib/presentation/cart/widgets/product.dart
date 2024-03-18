class Product {
  final String imageUrl;
  final String name;
  final num price;

  Product({required this.imageUrl, required this.name, required this.price});

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      imageUrl: map['imageUrl'] ?? '',
      name: map['name'] ?? '',
      price: map['price']?.toDouble() ?? 0,
    );
  }
}
