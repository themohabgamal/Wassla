import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:grad/core/networking/firebase_helper.dart';
import 'package:grad/core/paymob/constants.dart';
import 'package:grad/models/user.dart';

class PaymobManager {
  Dio dio = Dio();

  Future<String> getPaymentKey(int amount) async {
    try {
      String authToken = await _getAuthToken();
      int orderId = await _getOrderId(
          authToken: authToken, amount: (100 * amount).toString());
      String paymentKey = await _getPaymentKey(
        authToken: authToken,
        orderId: orderId.toString(),
        amount: (100 * amount).toString(),
      );
      return paymentKey;
    } catch (error) {
      print("Exc==============================");
      print(error.toString());
      rethrow;
    }
  }

  Future<void> handleTransactionResponse(String authToken, int orderId) async {
    try {
      Response response = await dio.post(
        'https://accept.paymobsolutions.com/api/acceptance/post_pay',
        data: {
          "auth_token": authToken,
          "order_id": orderId,
          // Add any other required parameters for the callback
        },
      );
      // Handle the response here, if needed
      print('Transaction response callback handled successfully');
      print('Response status code: ${response.statusCode}');
      print('Response data: ${response.data}');
    } catch (error) {
      print('Error handling transaction response callback: $error');
      // Handle the error here
    }
  }

  Future<String> _getAuthToken() async {
    try {
      Response response = await dio.post(
        'https://accept.paymob.com/api/auth/tokens',
        data: {"api_key": Constants.api_key},
      );

      return response.data['token'];
    } catch (error) {
      rethrow;
    }
  }

  Future<int> _getOrderId(
      {required String authToken, required String amount}) async {
    try {
      Response response = await dio.post(
        'https://accept.paymob.com/api/ecommerce/orders',
        data: {
          "auth_token": authToken,
          "delivery_needed": "true",
          "currency": "EGP",
          "amount_cents": amount,
          "items": []
        },
      );
      return response.data['id'];
    } catch (error) {
      rethrow;
    }
  }

  Future<String> _getPaymentKey({
    required String authToken,
    required String orderId,
    required String amount,
  }) async {
    try {
      MyUser? user = await FirebaseHelper().getCurrentUserData();
      Response response = await dio.post(
        'https://accept.paymob.com/api/acceptance/payment_keys',
        data: {
          "auth_token": authToken,
          "amount_cents": amount,
          "expiration": 3600,
          "order_id": orderId,
          "billing_data": {
            "apartment": "NA",
            "email": user!.email,
            "floor": "NA",
            "phone_number": user.phone.toString(),
            "first_name": user.firstName,
            "last_name": user.lastName,
            "street": "NA",
            "building": "NA",
            "shipping_method": "NA",
            "postal_code": "NA",
            "city": "NA",
            "country": "NA",
            "state": "NA"
          },
          "currency": "EGP",
          "integration_id": 4539675,
          "lock_order_when_paid": "false"
        },
      );

      return response.data['token'];
    } catch (error) {
      print('Error: $error');
      rethrow;
    }
  }
}
