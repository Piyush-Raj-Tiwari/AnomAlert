import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:anom_alert/firebase_options.dart';

class FirebaseApi {
  Future<void> initNotifications() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: true,
        carPlay: false,
        badge: true,
        criticalAlert: false,
        provisional: false,
        sound: true);
    print('User granted permission: ${settings.authorizationStatus}');
  }
}
