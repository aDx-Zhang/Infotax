import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:info_tax_square/Controllers/HomeController.dart';
import 'package:info_tax_square/PushNotificationService.dart';
import 'package:info_tax_square/Routes/MyRoutes.dart';
import 'package:info_tax_square/Screen/Splash/SplashScreen.dart';
import 'package:info_tax_square/Utils/Colors.dart';

FirebaseMessaging messaging = FirebaseMessaging.instance;
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
HomeController home = Get.put(HomeController());

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
 await PushNotificationService.init(flutterLocalNotificationsPlugin);
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('User granted permission');
  } else if (settings.authorizationStatus ==
      AuthorizationStatus.provisional) {
    print('User granted provisional permission');
  } else {
    print('User declined or has not accepted permission');
  }
  print('User granted permission: ${settings.authorizationStatus}');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  @override
  Widget build(BuildContext context) {

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        PushNotificationService.showNotification(
            id:  message.notification.hashCode,
            title: message.notification!.title!,
            body: message.notification!.body!,
            fln: flutterLocalNotificationsPlugin);
        print(
            'Message also contained a notification: ${message.notification!.title}');
        print(
            'Message also contained a notification: ${message.notification!.body}');
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (message.notification != null) {
        PushNotificationService.showNotification(
            id:  message.notification.hashCode,
            title: message.notification!.title!,
            body: message.notification!.body!,
            fln: flutterLocalNotificationsPlugin);
        print(
            'Message also contained a notification: ${message.notification!.title}');
        print(
            'Message also contained a notification: ${message.notification!.body}');
      }
    });
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        backgroundColor: AppColors.colorBackground,
      ),
      // home: SplashScreen(),
      getPages: MyRoutes.pages,
      home: SplashScreen(),
    );
  }
}

