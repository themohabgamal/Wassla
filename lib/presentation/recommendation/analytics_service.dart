import 'dart:developer';

import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsService {
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);
  static Future<void> logLikedProduct(
      String productId, String productName) async {
    print(
        'Logging liked product: productId=$productId, productName=$productName');
    analytics.setAnalyticsCollectionEnabled(true);
    try {
      analytics.logEvent(
        name: 'liked_product',
        parameters: <String, dynamic>{
          'product_id': productId,
          'product_name': productName,
        },
      );
      print('Liked product logged successfully');
    } catch (e) {
      print('Error logging liked product: $e');
    }
  }
}
