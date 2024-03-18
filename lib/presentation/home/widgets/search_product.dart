class SearchProduct {
  final String imageUrl;
  final String title;
  final String description;
  final double price;
  final int quantity;
  final String category;

  SearchProduct({
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.price,
    required this.quantity,
    required this.category,
  });

  factory SearchProduct.fromMap(Map<String, dynamic> map) {
    return SearchProduct(
      imageUrl: map['image'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      price: (map['price'] as num?)?.toDouble() ?? 0,
      quantity: (map['quantity'] as num?)?.toInt() ?? 0,
      category: map['category'] ?? '',
    );
  }
}
