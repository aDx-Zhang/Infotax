import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

firebaseCloudMessaging_Listeners() async {
  final fcmToken = await _firebaseMessaging.getToken();
  print("fcmToken $fcmToken");
}

class NotificationController extends GetxController {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static void initialize() {
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: AndroidInitializationSettings("app_icon"));
    _notificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (details) {
      print("onDidReceiveNotificationResponse function");
      print(details.payload);
      print(details.payload != null);
    });
  }

  static void showNotification(RemoteMessage message) {
    final NotificationDetails notiDetails = NotificationDetails(
        android: AndroidNotificationDetails(
            "com.infotaxsquare.lashari.info_tax_square", "push_notification",
            importance: Importance.max, priority: Priority.high));
    _notificationsPlugin.show(DateTime.now().microsecond,
        message.notification!.title, message.notification!.body, notiDetails,payload: message.data.toString());
  }

  requestNotificationPermission() async{

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
  }

  foregroundNotification(){
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });
  }

  @override
  void onInit() {
    super.onInit();
  }
}

