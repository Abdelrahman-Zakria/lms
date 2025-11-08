import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import '../error/failures.dart';

class DeviceInfoService {
  final DeviceInfoPlugin _deviceInfoPlugin = DeviceInfoPlugin();

  Future<String> getDeviceId() async {
    try {
      if (defaultTargetPlatform == TargetPlatform.android) {
        final androidInfo = await _deviceInfoPlugin.androidInfo;
        return androidInfo.id;
      } else if (defaultTargetPlatform == TargetPlatform.iOS) {
        final iosInfo = await _deviceInfoPlugin.iosInfo;
        return iosInfo.identifierForVendor ?? 'unknown_ios_device';
      } else {
        return 'unknown_device';
      }
    } catch (e) {
      throw DeviceInfoFailure('Failed to get device ID: ${e.toString()}');
    }
  }

      Future<String> getMobileType() async {
        try {
          if (defaultTargetPlatform == TargetPlatform.android) {
            return 'Apk';
          } else if (defaultTargetPlatform == TargetPlatform.iOS) {
            return 'ios';
          } else {
            return 'unknown';
          }
        } catch (e) {
          throw DeviceInfoFailure('Failed to get mobile type: ${e.toString()}');
        }
      }

  Future<String> getNotificationId() async {
    // For now, return a placeholder string as requested
    // In a real app, this would integrate with Firebase Cloud Messaging
    return 'notification_token_123';
  }
}
