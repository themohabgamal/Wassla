import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsService {
  static final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  static void logEvent(String id) async {
    print("uwu");

    await _analytics.logEvent(
      name: 'select_item',
      parameters: <String, dynamic>{
        'item_id': id,
      },
    );
  }
}
