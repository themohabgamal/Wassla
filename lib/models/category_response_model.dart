import 'package:grad/models/category_response_rating.dart';

class CategoryResponseModel {
  CategoryResponseModel({
    this.id,
    this.quantity,
    this.title,
    this.price,
    this.description,
    this.category,
    this.image,
  });

  CategoryResponseModel.fromJson(dynamic json) {
    id = json['id'];
    id = json['quantity'];
    title = json['title'];
    price = json['price'];
    description = json['description'];
    category = json['category'];
    image = json['image'];
  }
  num? id;
  String? title;
  num? price;
  num? quantity = 1;
  String? description;
  String? category;
  String? image;
  CategoryResponseModel copyWith({
    num? id,
    String? title,
    num? price,
    num? quantity,
    String? description,
    String? category,
    String? image,
  }) =>
      CategoryResponseModel(
        id: id ?? this.id,
        title: title ?? this.title,
        price: price ?? this.price,
        quantity: quantity ?? this.quantity,
        description: description ?? this.description,
        category: category ?? this.category,
        image: image ?? this.image,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['price'] = price;
    map['quantity'] = quantity;
    map['description'] = description;
    map['category'] = category;
    map['image'] = image;
    return map;
  }
}
