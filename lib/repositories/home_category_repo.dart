import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:grad/core/networking/firebase_helper.dart';
import 'package:grad/models/category_response_model.dart';

class HomeCategoryRepo {
  final FirebaseHelper firebaseHelper = FirebaseHelper();
  static Future<List<CategoryResponseModel>?> getSpecificCategory(
      String category) async {
    try {
      // Reference to the category document
      DocumentReference categoryRef =
          FirebaseFirestore.instance.collection('products').doc(category);

      // Get the products collection inside the category document
      QuerySnapshot productSnapshot =
          await categoryRef.collection('products').get();
      // Parse the data
      List<CategoryResponseModel> products = productSnapshot.docs.map((doc) {
        return CategoryResponseModel.fromJson(
            doc.data() as Map<String, dynamic>);
      }).toList();

      return products;
    } catch (error) {
      return null;
    }
  }

  Future<List<CategoryResponseModel>?> getAllProcuts() async {
    try {
      await firebaseHelper.getAllProducts();
    } catch (error) {
      log(error.toString());
    }
    return null;
  }
}
