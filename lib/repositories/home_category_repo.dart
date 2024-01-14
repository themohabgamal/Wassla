// ignore_for_file: invalid_return_type_for_catch_error

import 'dart:convert';

import 'package:grad/models/category_response_model.dart';
import 'package:http/http.dart' as http;

class HomeCategoryRepo {
  static Future<List<CategoryResponseModel>?> getSpeceficCategory(
      String category) {
    return http
        .get(Uri.parse('https://fakestoreapi.com/products/category/$category'))
        .then((data) {
      final products = <CategoryResponseModel>[];
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        for (var product in jsonData) {
          products.add(CategoryResponseModel.fromJson(product));
        }
        return products;
      }
    }).catchError((error) => print(error));
  }

  static Future<List<CategoryResponseModel>?> getAllProcuts() {
    return http
        .get(Uri.parse("https://fakestoreapi.com/products"))
        .then((data) {
      final products = <CategoryResponseModel>[];
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);
        for (var product in jsonData) {
          products.add(CategoryResponseModel.fromJson(product));
        }
        return products;
      }
    }).catchError((error) => print(error));
  }
}
