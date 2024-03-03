import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  final String id;
  final String name;
  final String image;
  final bool isFeatured;
  final String? parentId;

  CategoryModel(
      {required this.id,
      required this.name,
      required this.image,
      required this.isFeatured,
      this.parentId = ''});

  static CategoryModel empty() {
    return CategoryModel(
      id: '',
      name: '',
      image: '',
      isFeatured: false,
    );
  }

  factory CategoryModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data();
      return CategoryModel(
        id: document.id,
        name: data?['name'],
        image: data?['image'],
        isFeatured: data?['isFeatured'],
        parentId: data?['parentId'],
      );
    } else {
      return CategoryModel.empty();
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'isFeatured': isFeatured,
      'parentId': parentId,
    };
  }
}
