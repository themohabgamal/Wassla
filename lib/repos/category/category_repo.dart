import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grad/models/category/category_model.dart';

class CategoryRepo {
  final firestore = FirebaseFirestore.instance;
  //* get all categories
  Future<List<CategoryModel>> getAllCategories() async {
    try {
      final snapshot = await firestore.collection('Categories').get();
      final list = snapshot.docs
          .map((document) => CategoryModel.fromSnapshot(document))
          .toList();
      return list;
    } catch (e) {
      log(e.toString());
      return [];
    }
  }
}
