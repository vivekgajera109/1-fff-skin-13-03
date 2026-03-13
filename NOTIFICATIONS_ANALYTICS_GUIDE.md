# Push Notifications & Analytics Integration Guide

## 📋 Overview

This document provides a comprehensive guide for the integrated **Push Notifications** and **Analytics** systems in the FFF Skin Tools application.

---

## 🔔 Push Notifications

### Features Implemented

1. **Firebase Cloud Messaging (FCM)** integration
2. **Local Notifications** with custom sounds and channels
3. **Background & Foreground** message handling
4. **Notification Channels** for organized notifications (Android)
5. **iOS Support** with proper permission handling
6. **FCM Token Management** with automatic refresh
7. **Notification Tap Handling** for deep linking

### Notification Channels

The app uses three notification channels (Android):

| Channel ID | Name | Description | Importance |
|------------|------|-------------|------------|
| `general_channel` | General Notifications | General app notifications | High |
| `promo_channel` | Promotions & Updates | Special offers and new content alerts | Max (with custom sound) |
| `alert_channel` | Important Alerts | Critical app alerts | Max (with vibration) |

### Usage Examples

#### Send a Local Notification

```dart
import 'package:fff_skin_tools/helper/notification_service.dart';

// Simple notification
await NotificationService.showLocalNotification(
  title: 'New Character Available!',
  body: 'Check out the latest diamond character in the shop.',
);

// Notification with specific channel
await NotificationService.showLocalNotification(
  title: 'Limited Time Offer!',
  body: 'Get 50% off on all bundles today only!',
  channelId: 'promo_channel',
  payload: 'bundles_screen',
);
```

#### Get FCM Token

```dart
String? token = NotificationService.fcmToken;
print('FCM Token: $token');
```

#### Cancel Notifications

```dart
// Cancel all notifications
await NotificationService.cancelAllNotifications();

// Cancel specific notification
await NotificationService.cancelNotification(notificationId);
```

### Firebase Console Setup

To send push notifications from Firebase Console:

1. Go to **Firebase Console** → **Cloud Messaging**
2. Click **Send your first message**
3. Fill in:
   - **Notification title**: e.g., "New Update Available"
   - **Notification text**: e.g., "Version 2.0 is now live!"
   - **Target**: Select your app
4. **Additional options**:
   - **Custom data**: Add `channel_id` key with value `promo_channel` or `alert_channel`
   - **Sound**: Will use channel-specific sound

### Notification Payload Structure

When sending from Firebase Console or server:

```json
{
  "notification": {
    "title": "New Character Available",
    "body": "Check out the latest diamond character!"
  },
  "data": {
    "channel_id": "promo_channel",
    "payload": "characters_screen",
    "item_id": "character_123"
  }
}
```

---

## 📊 Analytics

### Features Implemented

1. **Screen View Tracking**
2. **Event Logging** (user actions, navigation, errors)
3. **User Properties** (FCM token, preferences)
4. **Ad Interaction Tracking** (impressions, clicks)
5. **Item View & Click Tracking**
6. **Custom Event Parameters**

### Analytics Events

#### Automatically Tracked Events

| Event Name | Description | Parameters |
|------------|-------------|------------|
| `screen_view` | User views a screen | `screen_name`, `screen_class` |
| `app_open` | App is opened | - |
| `notification_received_foreground` | Notification received while app is open | `title`, `message_id` |
| `notification_received_background` | Notification received in background | `title`, `message_id` |
| `notification_tapped` | User taps on notification | `payload` |
| `ad_impression` | Ad is displayed | `ad_type`, `ad_location` |
| `ad_click` | User clicks on ad | `ad_type`, `ad_location` |
| `select_item` | User clicks on item | `item_id`, `item_name`, `item_category` |
| `view_item` | User views item details | `item_id`, `item_name`, `item_category` |

#### Custom Events

You can log custom events throughout the app:

```dart
import 'package:fff_skin_tools/helper/analytics_service.dart';

// Log custom event
await AnalyticsService.logEvent(
  eventName: 'user_completed_tutorial',
  parameters: {
    'tutorial_name': 'character_selection',
    'completion_time': '45',
  },
);
```

### Usage Examples

#### Track Screen Views

```dart
// In your StatefulWidget's initState
@override
void initState() {
  super.initState();
  AnalyticsService.logScreenView(screenName: 'CharactersScreen');
}
```

#### Track User Actions

```dart
// Item click
await AnalyticsService.logItemClick(
  itemId: 'diamond_character_001',
  itemName: 'Elite Warrior',
  category: 'characters',
);

// Item view
await AnalyticsService.logItemView(
  itemId: 'diamond_character_001',
  itemName: 'Elite Warrior',
  category: 'characters',
);

// Analysis complete
await AnalyticsService.logAnalysisComplete(
  itemName: 'Elite Warrior',
  category: 'characters',
);
```

#### Track Navigation

```dart
await AnalyticsService.logNavigation(
  from: 'HomeScreen',
  to: 'CharactersScreen',
);
```

#### Track Errors

```dart
try {
  // Some operation
} catch (e, stackTrace) {
  await AnalyticsService.logError(
    errorMessage: e.toString(),
    stackTrace: stackTrace.toString(),
  );
}
```

#### Set User Properties

```dart
// Set user ID
await AnalyticsService.setUserId('user_12345');

// Set custom property
await AnalyticsService.setUserProperty(
  name: 'preferred_category',
  value: 'characters',
);
```

### Viewing Analytics Data

1. Go to **Firebase Console** → **Analytics** → **Events**
2. View real-time events in **DebugView** (requires debug mode)
3. Check **Dashboards** for aggregated data
4. Use **Custom Reports** for specific insights

### Debug Mode (Testing)

To enable analytics debug mode:

**Android:**
```bash
adb shell setprop debug.firebase.analytics.app com.excellent.enterprise.fff.tool.new
```

**iOS:**
Add `-FIRAnalyticsDebugEnabled` to Xcode scheme arguments.

---

## 🚀 Implementation Checklist

### ✅ Completed

- [x] Firebase Analytics integration
- [x] Firebase Cloud Messaging setup
- [x] Local notifications with channels
- [x] Background message handler
- [x] Foreground message handler
- [x] Notification tap handling
- [x] FCM token management
- [x] Analytics service with comprehensive events
- [x] Screen view tracking
- [x] Ad impression & click tracking
- [x] Item view & click tracking
- [x] User property tracking
- [x] Error logging

### 📝 Recommended Next Steps

1. **Server-Side Integration**
   - Set up a backend to send targeted push notifications
   - Store FCM tokens in your database
   - Implement user segmentation for targeted campaigns

2. **Advanced Analytics**
   - Create custom conversion funnels
   - Set up A/B testing with Firebase Remote Config
   - Implement user cohort analysis

3. **Notification Strategies**
   - Welcome notification for new users
   - Re-engagement notifications for inactive users
   - Promotional notifications for special offers
   - Update notifications for new content

4. **Deep Linking**
   - Implement navigation based on notification payload
   - Handle specific screen navigation from notifications

---

## 🔧 Configuration Files

### Android Manifest (`android/app/src/main/AndroidManifest.xml`)

Ensure you have the following permissions:

```xml
<uses-permission android:name="android.permission.INTERNET"/>
<uses-permission android:name="android.permission.POST_NOTIFICATIONS"/>
```

### iOS Info.plist (`ios/Runner/Info.plist`)

Add notification permissions:

```xml
<key>UIBackgroundModes</key>
<array>
    <string>fetch</string>
    <string>remote-notification</string>
</array>
```

---

## 📱 Testing

### Test Push Notifications

1. **Using Firebase Console**:
   - Go to Cloud Messaging
   - Send test message to your device token
   - Check notification appears

2. **Using FCM API**:
   ```bash
   curl -X POST https://fcm.googleapis.com/fcm/send \
     -H "Authorization: key=YOUR_SERVER_KEY" \
     -H "Content-Type: application/json" \
     -d '{
       "to": "DEVICE_FCM_TOKEN",
       "notification": {
         "title": "Test Notification",
         "body": "This is a test message"
       }
     }'
   ```

### Test Analytics

1. Enable debug mode (see above)
2. Open Firebase Console → Analytics → DebugView
3. Perform actions in the app
4. Verify events appear in DebugView

---

## 🐛 Troubleshooting

### Notifications Not Appearing

1. **Check permissions**: Ensure notification permissions are granted
2. **Verify FCM token**: Check if token is being generated
3. **Check channels**: Ensure notification channels are created (Android)
4. **Test in foreground & background**: Behavior differs

### Analytics Not Tracking

1. **Check Firebase initialization**: Ensure Firebase is initialized before analytics calls
2. **Enable debug mode**: Use debug mode to see events in real-time
3. **Wait for data**: Analytics data can take 24 hours to appear in reports
4. **Check internet connection**: Analytics requires internet to sync

### Common Errors

| Error | Solution |
|-------|----------|
| "FCM token is null" | Wait for initialization, check Google Services |
| "Notification channel not found" | Ensure channels are created in `_createNotificationChannels()` |
| "Analytics not initialized" | Call analytics after Firebase initialization |

---

## 📚 Additional Resources

- [Firebase Cloud Messaging Documentation](https://firebase.google.com/docs/cloud-messaging)
- [Firebase Analytics Documentation](https://firebase.google.com/docs/analytics)
- [Flutter Local Notifications Plugin](https://pub.dev/packages/flutter_local_notifications)
- [Firebase Analytics Events](https://firebase.google.com/docs/reference/android/com/google/firebase/analytics/FirebaseAnalytics.Event)

---

## 💡 Best Practices

1. **Don't spam users** with too many notifications
2. **Personalize notifications** based on user behavior
3. **Test thoroughly** on both Android and iOS
4. **Monitor analytics** regularly to understand user behavior
5. **Respect user privacy** - only track necessary data
6. **Handle errors gracefully** - don't crash on analytics failures
7. **Use meaningful event names** - follow Firebase naming conventions

---

**Last Updated**: February 12, 2026
**Version**: 1.0.0
