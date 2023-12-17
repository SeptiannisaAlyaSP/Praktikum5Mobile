import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Message received in background: ${message.notification?.title}');
}

class FirebaseMessagingHandler {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initPushNotification() async {
    // Allow the user to give permission for notifications
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    print('User granted permission: ${settings.authorizationStatus}');

    // Get FCM token
    _firebaseMessaging.getToken().then((token) {
      print('FCM Token: $token');
    });

    // Handle terminated message
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      print("Terminated Notification: ${message?.notification?.title}");
    });

    // Handle background message
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // Handle foreground message
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Message received in foreground: ${message.notification?.title}');
    });

    // Handle message when the app is in the foreground and opened
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Message opened app: ${message.notification?.title}');
    });
  }
}
