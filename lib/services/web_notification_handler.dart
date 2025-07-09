// This file will only be included in web builds
import 'dart:html' as html;
import 'package:firebase_messaging/firebase_messaging.dart';

class WebNotificationHandler {
  static Future<void> showNotification(RemoteMessage message) async {
    RemoteNotification? remoteNotification = message.notification;
    if (remoteNotification != null) {
      if (html.Notification.permission == 'granted') {
        final notification = html.Notification(
          remoteNotification.title ?? 'New Notification',
          body: remoteNotification.body,
          icon: '/icons/Icon-192.png',
        );

        notification.onClick.listen((event) {
          notification.close();
        });
      }
    }
  }
}
