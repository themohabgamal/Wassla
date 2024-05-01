import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:grad/models/category_response_model.dart';

class ApiHelper {
  Future<List<CategoryResponseModel>?> getRecommendedProducts() async {
    String baseUrl = 'http://10.0.2.2:5000';
    String endpoint = '/recommendations';

    String url = '$baseUrl$endpoint';

    try {
      Response response = await Dio()
          .post(url, data: {'user_id': FirebaseAuth.instance.currentUser!.uid});

      if (response.statusCode == 200) {
        // Handle successful response
        List<CategoryResponseModel> recommendedProducts = [];
        // Parse response data and create CategoryResponseModel objects
        List<dynamic> responseData = response.data;
        for (var productData in responseData) {
          CategoryResponseModel product =
              CategoryResponseModel.fromJson(productData);
          recommendedProducts.add(product);
        }
        return recommendedProducts;
      } else if (response.statusCode == 404 &&
          response.data['error'] == 'User has no items in wishlist') {
        // Handle case where user has no items in wishlist
        return null; // Return null to indicate no recommendations
      } else {
        // Handle other error responses
        print('Failed to fetch data: ${response.statusCode}');
        throw Exception('Failed to fetch data: ${response.statusCode}');
      }
    } catch (error) {
      // Handle error
      print('Error: $error');
      rethrow;
    }
  }
}
