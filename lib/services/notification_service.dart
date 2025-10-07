import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

class NotificationService {
  NotificationService._();
  static final NotificationService instance = NotificationService._();

  Future<void> init() async {
    try {
      final messaging = FirebaseMessaging.instance;
      await messaging.requestPermission();
      if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
        await messaging.getToken();
        FirebaseMessaging.onMessage.listen((msg) {
          debugPrint('FCM message: ${msg.notification?.title}');
        });
      }
    } catch (e) {
      debugPrint('FCM no disponible: $e');
    }
  }

  Future<void> sendLocalLike(String title, String body) async {
    // MVP: solo log. En producción, integrar flutter_local_notifications.
    debugPrint('[NOTIF] $title - $body');
  }
}
