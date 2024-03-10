import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  final String title;
  final String image;

  CategoryModel({
    required this.title,
    required this.image,
  });

  static CategoryModel empty() {
    return CategoryModel(
      title: '',
      image: '',
    );
  }

  factory CategoryModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data();
      return CategoryModel(
        title: data?['title'],
        image: data?['image'],
      );
    } else {
      return CategoryModel.empty();
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'image': image,
    };
  }
}
