class HotDealModel {
  final String description;
  final double discountedPrice;
  final String image;
  final double originalPrice;
  final int quantity;
  final String title;

  HotDealModel({
    required this.description,
    required this.discountedPrice,
    required this.image,
    required this.originalPrice,
    required this.quantity,
    required this.title,
  });

  HotDealModel.fromJson(dynamic json)
      : description = json['description'] ?? '',
        discountedPrice = (json['discounted_price'] ?? 0).toDouble(),
        image = json['image'] ?? '',
        originalPrice = (json['original_price'] ?? 0).toDouble(),
        quantity = json['quantity'] ?? 0,
        title = json['title'] ?? '';

  Map<String, dynamic> toJson() {
    return {
      'description': description,
      'discounted_price': discountedPrice,
      'image': image,
      'original_price': originalPrice,
      'quantity': quantity,
      'title': title,
    };
  }
}
