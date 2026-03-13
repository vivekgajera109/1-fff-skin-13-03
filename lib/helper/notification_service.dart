import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fff_skin_tools/helper/analytics_service.dart';

/// ===================================================================
/// 🔔 NOTIFICATION SERVICE - Push Notifications & Local Notifications
/// ===================================================================

/// Background message handler (must be top-level function)
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  log('🔔 Background Message: ${message.notification?.title}');

  // Log analytics for background notifications
  await AnalyticsService.logEvent(
    eventName: 'notification_received_background',
    parameters: {
      'title': message.notification?.title ?? 'N/A',
      'message_id': message.messageId ?? 'N/A',
    },
  );
}

class NotificationService {
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static final FirebaseMessaging _firebaseMessaging =
      FirebaseMessaging.instance;

  static String? _fcmToken;

  /// Initialize notification service
  static Future<void> initialize() async {
    // Request permissions (iOS)
    await _requestPermissions();

    // Initialize local notifications
    await _initializeLocalNotifications();

    // Initialize Firebase Messaging
    await _initializeFirebaseMessaging();

    // Get FCM token
    await _getFCMToken();

    // Listen to token refresh
    _firebaseMessaging.onTokenRefresh.listen((newToken) {
      _fcmToken = newToken;
      log('🔔 FCM Token Refreshed: $newToken');
      AnalyticsService.setUserProperty(name: 'fcm_token', value: newToken);
    });
  }

  /// Request notification permissions (iOS)
  static Future<void> _requestPermissions() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    log('🔔 Notification Permission: ${settings.authorizationStatus}');

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      log('✅ User granted notification permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      log('⚠️ User granted provisional notification permission');
    } else {
      log('❌ User declined notification permission');
    }
  }

  /// Initialize local notifications
  static Future<void> _initializeLocalNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _onNotificationTapped,
    );

    // Create notification channels (Android)
    await _createNotificationChannels();
  }

  /// Create notification channels for Android
  static Future<void> _createNotificationChannels() async {
    const AndroidNotificationChannel generalChannel =
        AndroidNotificationChannel(
      'general_channel',
      'General Notifications',
      description: 'General app notifications',
      importance: Importance.high,
      playSound: true,
    );

    const AndroidNotificationChannel promoChannel = AndroidNotificationChannel(
      'promo_channel',
      'Promotions & Updates',
      description: 'Special offers and new content alerts',
      importance: Importance.max,
      playSound: true,
      sound: RawResourceAndroidNotificationSound('alert_sound'),
    );

    const AndroidNotificationChannel alertChannel = AndroidNotificationChannel(
      'alert_channel',
      'Important Alerts',
      description: 'Critical app alerts',
      importance: Importance.max,
      playSound: true,
      enableVibration: true,
    );

    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(generalChannel);

    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(promoChannel);

    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(alertChannel);

    log('✅ Notification channels created');
  }

  /// Initialize Firebase Messaging
  static Future<void> _initializeFirebaseMessaging() async {
    // Background message handler
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // Foreground message handler
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log('🔔 Foreground Message: ${message.notification?.title}');

      if (message.notification != null) {
        showLocalNotification(
          title: message.notification!.title ?? 'New Notification',
          body: message.notification!.body ?? '',
          channelId: message.data['channel_id'] ?? 'general_channel',
          payload: message.data['payload'],
        );
      }

      // Log analytics
      AnalyticsService.logEvent(
        eventName: 'notification_received_foreground',
        parameters: {
          'title': message.notification?.title ?? 'N/A',
          'message_id': message.messageId ?? 'N/A',
        },
      );
    });

    // Handle notification taps when app is in background
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      log('🔔 Notification Opened (Background): ${message.notification?.title}');
      _handleNotificationTap(message.data);
    });

    // Check if app was opened from a terminated state via notification
    RemoteMessage? initialMessage =
        await _firebaseMessaging.getInitialMessage();
    if (initialMessage != null) {
      log('🔔 Notification Opened (Terminated): ${initialMessage.notification?.title}');
      _handleNotificationTap(initialMessage.data);
    }
  }

  /// Get FCM token
  static Future<String?> _getFCMToken() async {
    try {
      _fcmToken = await _firebaseMessaging.getToken();
      log('🔔 FCM Token: $_fcmToken');

      if (_fcmToken != null) {
        // Store token in analytics
        await AnalyticsService.setUserProperty(
          name: 'fcm_token',
          value: _fcmToken!,
        );
      }

      return _fcmToken;
    } catch (e) {
      log('❌ Error getting FCM token: $e');
      return null;
    }
  }

  /// Get current FCM token
  static String? get fcmToken => _fcmToken;

  /// Show local notification
  static Future<void> showLocalNotification({
    required String title,
    required String body,
    String channelId = 'general_channel',
    String? payload,
  }) async {
    AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      channelId,
      _getChannelName(channelId),
      channelDescription: _getChannelDescription(channelId),
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      sound: channelId == 'promo_channel'
          ? const RawResourceAndroidNotificationSound('alert_sound')
          : null,
      styleInformation: BigTextStyleInformation(body),
    );

    const DarwinNotificationDetails iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _flutterLocalNotificationsPlugin.show(
      DateTime.now().millisecondsSinceEpoch ~/ 1000,
      title,
      body,
      platformChannelSpecifics,
      payload: payload,
    );

    log('✅ Local notification shown: $title');
  }

  /// Handle notification tap
  static void _onNotificationTapped(NotificationResponse response) {
    log('🔔 Notification Tapped: ${response.payload}');

    if (response.payload != null) {
      _handleNotificationTap({'payload': response.payload});
    }

    // Log analytics
    AnalyticsService.logEvent(
      eventName: 'notification_tapped',
      parameters: {
        'payload': response.payload ?? 'N/A',
      },
    );
  }

  /// Handle notification tap navigation
  static void _handleNotificationTap(Map<String, dynamic> data) {
    // TODO: Implement navigation based on payload
    // Example: Navigate to specific screen based on data['screen']
    log('🔔 Handling notification tap with data: $data');
  }

  /// Helper: Get channel name
  static String _getChannelName(String channelId) {
    switch (channelId) {
      case 'promo_channel':
        return 'Promotions & Updates';
      case 'alert_channel':
        return 'Important Alerts';
      default:
        return 'General Notifications';
    }
  }

  /// Helper: Get channel description
  static String _getChannelDescription(String channelId) {
    switch (channelId) {
      case 'promo_channel':
        return 'Special offers and new content alerts';
      case 'alert_channel':
        return 'Critical app alerts';
      default:
        return 'General app notifications';
    }
  }

  /// Cancel all notifications
  static Future<void> cancelAllNotifications() async {
    await _flutterLocalNotificationsPlugin.cancelAll();
    log('🔔 All notifications cancelled');
  }

  /// Cancel specific notification
  static Future<void> cancelNotification(int id) async {
    await _flutterLocalNotificationsPlugin.cancel(id);
    log('🔔 Notification $id cancelled');
  }

  /// Schedule a notification
  static Future<void> scheduleNotification({
    required String title,
    required String body,
    required DateTime scheduledTime,
    String channelId = 'general_channel',
  }) async {
    // Note: Requires timezone package for proper scheduling
    log('⏰ Scheduled notification: $title at $scheduledTime');
    // Implementation would use zonedSchedule from flutter_local_notifications
  }
}
