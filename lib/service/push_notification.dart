import 'dart:ui';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
  PushNotificationService().showLocalNotification(message);

}

class PushNotificationService {
  late final FirebaseMessaging _firebaseMessaging;
  late final AndroidNotificationChannel channel;
  late final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  void registerNotification() async {

    await enableIOSNotifications();

    _firebaseMessaging = FirebaseMessaging.instance;

    //initialize local notification
    initLocalNotification();

    // Add the following line
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // 3. On iOS, this helps to take the user permissions
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('User granted permission!');
    /// For handling the received notifications
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Inside Using App => $message');
      showLocalNotification(message);

    });

    RemoteMessage? message = await FirebaseMessaging.instance.getInitialMessage();
    if (message != null) {
      print('App is not Active => $message');
      onSelectNoti('home');
    }
    } else {
      print('User declined or has not accepted permission');
    }
  }

  void initLocalNotification() async{
    channel = androidNotificationChannel();
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    var androidSettings = const AndroidInitializationSettings('@drawable/ic_notification');
    var iOSSettings = const IOSInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
    );
    var initSetttings = InitializationSettings(android: androidSettings, iOS: iOSSettings);
    flutterLocalNotificationsPlugin.initialize(initSetttings,);

  }

  enableIOSNotifications() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );
  }

  androidNotificationChannel() => const AndroidNotificationChannel(
    'example_high_importance_channel', // id
    'Example High Importance Notifications', // title
    description: 'This channel is used for example notifications.', // description
    importance: Importance.high,
    playSound: true,
    sound: RawResourceAndroidNotificationSound('notification_sound'),
  );

  Future<dynamic> onSelectNoti(String message) async {
    if(message == 'home'){
      //Go to Home
    }
  }

  void showLocalNotification(RemoteMessage message) {
    flutterLocalNotificationsPlugin.show(
      message.notification.hashCode,
      message.notification!.title,
      message.notification!.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          playSound: true,
          channelShowBadge: true,
          importance: Importance.high,
          priority: Priority.high,
          sound: RawResourceAndroidNotificationSound('notification_sound'),
          color: const Color.fromARGB(255, 255, 153, 0),
        ),
      ),
      payload: '$message', // set the value of payload
    );
  }
}