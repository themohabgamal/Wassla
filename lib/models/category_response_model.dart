import 'package:grad/models/category_response_rating.dart';

/// id : 5
/// title : "John Hardy Women's Legends Naga Gold & Silver Dragon Station Chain Bracelet"
/// price : 695
/// description : "From our Legends Collection, the Naga was inspired by the mythical water dragon that protects the ocean's pearl. Wear facing inward to be bestowed with love and abundance, or outward for protection."
/// category : "jewelery"
/// image : "https://fakestoreapi.com/img/71pWzhdJNwL._AC_UL640_QL65_ML3_.jpg"
/// rating : {"rate":4.6,"count":400}

class CategoryResponseModel {
  CategoryResponseModel({
    this.id,
    this.quantity,
    this.title,
    this.price,
    this.description,
    this.category,
    this.image,
    this.rating,
  });

  CategoryResponseModel.fromJson(dynamic json) {
    id = json['id'];
    id = json['quantity'];
    title = json['title'];
    price = json['price'];
    description = json['description'];
    category = json['category'];
    image = json['image'];
    rating = json['rating'] != null ? Rating.fromJson(json['rating']) : null;
  }
  num? id;
  String? title;
  num? price;
  num? quantity = 1;
  String? description;
  String? category;
  String? image;
  Rating? rating;
  CategoryResponseModel copyWith({
    num? id,
    String? title,
    num? price,
    num? quantity,
    String? description,
    String? category,
    String? image,
    Rating? rating,
  }) =>
      CategoryResponseModel(
        id: id ?? this.id,
        title: title ?? this.title,
        price: price ?? this.price,
        quantity: quantity ?? this.quantity,
        description: description ?? this.description,
        category: category ?? this.category,
        image: image ?? this.image,
        rating: rating ?? this.rating,
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
    if (rating != null) {
      map['rating'] = rating?.toJson();
    }
    return map;
  }
}
