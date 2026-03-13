import 'dart:developer';
import 'package:firebase_remote_config/firebase_remote_config.dart';

class RemoteConfigService {
  static final FirebaseRemoteConfig _remoteConfig =
      FirebaseRemoteConfig.instance;

  static Future<void> initialize() async {
    try {
      await _remoteConfig.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(seconds: 10),
          minimumFetchInterval: Duration.zero,
        ),
      );

      // ✅ Default values
      await _remoteConfig.setDefaults({
        'redirect_url': '',
        'app_url': '',
        'privacy_policy_link': '',
        'is_ads_show': true, // 👈 default
      });

      await _remoteConfig.fetchAndActivate();
      log("Remote Config initialized successfully");
    } catch (e) {
      log("Remote Config initialization failed: $e");
    }
  }

  // --------------------------------------------------
  // BOOL : SHOW ADS
  // --------------------------------------------------
  static bool get isAdsShow {
    try {
      final String val =
          _remoteConfig.getString('is_ads_show').toLowerCase().trim();
      if (val == 'false' || val == '0' || val == 'no' || val == 'off') {
        return false;
      }
      if (val == 'true' || val == '1' || val == 'yes' || val == 'on') {
        return true;
      }
      return _remoteConfig.getBool('is_ads_show');
    } catch (e) {
      log("Error getting is_ads_show: $e");
      return false; // safe default
    }
  }

  // --------------------------------------------------
  // STRING : REDIRECT URL
  // --------------------------------------------------
  static String getRedirectUrl() {
    try {
      return _remoteConfig.getString('redirect_url');
    } catch (e) {
      log("Error getting redirect_url: $e");
      return '';
    }
  }

  // --------------------------------------------------
  // STRING : APP URL
  // --------------------------------------------------
  static String getAppUrl() {
    try {
      return _remoteConfig.getString('app_link');
    } catch (e) {
      log("Error getting app_url: $e");
      return '';
    }
  }

  // --------------------------------------------------
  // STRING : PRIVACY POLICY URL
  // --------------------------------------------------
  static String getPrivacyPolicyUrl() {
    try {
      return _remoteConfig.getString('privacy_policy_link');
    } catch (e) {
      log("Error getting privacy_policy_link: $e");
      return '';
    }
  }
}
