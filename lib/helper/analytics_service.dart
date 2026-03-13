import 'dart:developer';
import 'package:firebase_analytics/firebase_analytics.dart';

/// ===================================================================
/// 🔥 ANALYTICS SERVICE - Firebase Analytics Integration
/// ===================================================================
class AnalyticsService {
  static final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  /// Log screen views
  static Future<void> logScreenView({
    required String screenName,
    String? screenClass,
  }) async {
    try {
      await _analytics.logScreenView(
        screenName: screenName,
        screenClass: screenClass ?? screenName,
      );
      log('📊 Analytics: Screen View - $screenName');
    } catch (e) {
      log('❌ Analytics Error (Screen View): $e');
    }
  }

  /// Log user engagement events
  static Future<void> logEvent({
    required String eventName,
    Map<String, Object>? parameters,
  }) async {
    try {
      await _analytics.logEvent(
        name: eventName,
        parameters: parameters,
      );
      log('📊 Analytics: Event - $eventName ${parameters ?? ""}');
    } catch (e) {
      log('❌ Analytics Error (Event): $e');
    }
  }

  /// Log when user views a character/item
  static Future<void> logItemView({
    required String itemId,
    required String itemName,
    required String category,
  }) async {
    await logEvent(
      eventName: 'view_item',
      parameters: {
        'item_id': itemId,
        'item_name': itemName,
        'item_category': category,
      },
    );
  }

  /// Log when user clicks on an item
  static Future<void> logItemClick({
    required String itemId,
    required String itemName,
    required String category,
  }) async {
    await logEvent(
      eventName: 'select_item',
      parameters: {
        'item_id': itemId,
        'item_name': itemName,
        'item_category': category,
      },
    );
  }

  /// Log when user completes the analysis flow
  static Future<void> logAnalysisComplete({
    required String itemName,
    required String category,
  }) async {
    await logEvent(
      eventName: 'analysis_complete',
      parameters: {
        'item_name': itemName,
        'category': category,
        'timestamp': DateTime.now().toIso8601String(),
      },
    );
  }

  /// Log ad interactions
  static Future<void> logAdClick({
    required String adType, // 'banner', 'native', 'interstitial'
    String? adLocation,
  }) async {
    await logEvent(
      eventName: 'ad_click',
      parameters: {
        'ad_type': adType,
        'ad_location': adLocation ?? 'unknown',
      },
    );
  }

  /// Log when user views an ad
  static Future<void> logAdImpression({
    required String adType,
    String? adLocation,
  }) async {
    await logEvent(
      eventName: 'ad_impression',
      parameters: {
        'ad_type': adType,
        'ad_location': adLocation ?? 'unknown',
      },
    );
  }

  /// Log user navigation
  static Future<void> logNavigation({
    required String from,
    required String to,
  }) async {
    await logEvent(
      eventName: 'navigation',
      parameters: {
        'from_screen': from,
        'to_screen': to,
      },
    );
  }

  /// Log app opens
  static Future<void> logAppOpen() async {
    await logEvent(eventName: 'app_open');
  }

  /// Log onboarding completion
  static Future<void> logOnboardingComplete() async {
    await logEvent(
      eventName: 'onboarding_complete',
      parameters: {
        'timestamp': DateTime.now().toIso8601String(),
      },
    );
  }

  /// Log share events
  static Future<void> logShare({
    required String contentType,
    required String itemId,
  }) async {
    await logEvent(
      eventName: 'share',
      parameters: {
        'content_type': contentType,
        'item_id': itemId,
      },
    );
  }

  /// Set user properties
  static Future<void> setUserProperty({
    required String name,
    required String value,
  }) async {
    try {
      await _analytics.setUserProperty(name: name, value: value);
      log('📊 Analytics: User Property Set - $name: $value');
    } catch (e) {
      log('❌ Analytics Error (User Property): $e');
    }
  }

  /// Set user ID
  static Future<void> setUserId(String userId) async {
    try {
      await _analytics.setUserId(id: userId);
      log('📊 Analytics: User ID Set - $userId');
    } catch (e) {
      log('❌ Analytics Error (User ID): $e');
    }
  }

  /// Log search events
  static Future<void> logSearch(String searchTerm) async {
    await logEvent(
      eventName: 'search',
      parameters: {
        'search_term': searchTerm,
      },
    );
  }

  /// Log tutorial/guide views
  static Future<void> logTutorialView(String tutorialName) async {
    await logEvent(
      eventName: 'tutorial_begin',
      parameters: {
        'tutorial_name': tutorialName,
      },
    );
  }

  /// Log errors for debugging
  static Future<void> logError({
    required String errorMessage,
    String? stackTrace,
  }) async {
    await logEvent(
      eventName: 'app_error',
      parameters: {
        'error_message': errorMessage,
        'stack_trace': stackTrace ?? 'N/A',
        'timestamp': DateTime.now().toIso8601String(),
      },
    );
  }
}
