import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:lms/firebase_options.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await setupFlutterNotifications();
  showFlutterNotification(message);
  debugPrint('Handling a background message ${message.messageId}');
}

Future<void> firebaseMessagingForgroundHandler() async {
  FirebaseMessaging.onMessage.listen((message) {
    debugPrint(message.data.toString());
    debugPrint(message.toString());
    debugPrint('Handling a ForeGround message ${message.messageId}');
    debugPrint('Handling a ForeGround message ${message.notification?.title}');
    showFlutterNotification(message);
  });
}

void handleMessage(RemoteMessage? message) {
  if (message == null) return;
  if (message.data['type'] == 'Conversetion') {
    // ContextLess.navigatorkey.currentState!
    //     .pushNamedAndRemoveUntil(Routes.homeScreen, (route) => false);
    // ContextLess.navigatorkey.currentState!.pushNamed(
    //   Routes.messageScreen,
    //   arguments: MessageScreenArgument(
    //     orderId: int.parse(message.data['orderId'].toString()),
    //     senderId: int.parse(message.data['receiverId'].toString()),
    //     receiverId: int.parse(message.data['senderId'].toString()),
    //   ),
    // );
  }
}

/// Create a [AndroidNotificationChannel] for heads up notifications
late AndroidNotificationChannel channel;

bool isFlutterLocalNotificationsInitialized = false;

Future<void> setupFlutterNotifications() async {
  if (isFlutterLocalNotificationsInitialized) {
    return;
  }
  channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin>()
      ?.requestPermissions(
        alert: true,
        badge: true,
      );

  const InitializationSettings initializationSettings = InitializationSettings(
    android: AndroidInitializationSettings('@drawable/ic_stat_launcher'),
    iOS: DarwinInitializationSettings(),
  );
  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveBackgroundNotificationResponse: onDidReceiveLocalNotification,
    onDidReceiveNotificationResponse: onSelectNotification,
  );

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  isFlutterLocalNotificationsInitialized = true;
}

Future<void> onSelectNotification(
  NotificationResponse notificationResponse,
) async {
  // final List<String> parts = notificationResponse.payload!.split('_');
  // final int orderId = int.parse(parts[0]);
  // final int senderId = int.parse(parts[1]);
  // final int receiverId = int.parse(parts[2]);
  // ContextLess.navigatorkey.currentState!.pushNamedAndRemoveUntil(
  //   Routes.messageScreen,
  //   arguments: MessageScreenArgument(
  //     orderId: orderId,
  //     senderId: receiverId,
  //     receiverId: senderId,
  //   ),
  //   (route) => true,
  // );
}

Future<void> onDidReceiveLocalNotification(
  NotificationResponse notificationResponse,
) async {
  // final List<String> parts = notificationResponse.payload!.split('_');
  // final int orderId = int.parse(parts[0]);
  // final int senderId = int.parse(parts[1]);
  // final int receiverId = int.parse(parts[2]);
  // ContextLess.navigatorkey.currentState!.pushNamedAndRemoveUntil(
  //   Routes.messageScreen,
  //   arguments: MessageScreenArgument(
  //     orderId: orderId,
  //     senderId: receiverId,
  //     receiverId: senderId,
  //   ),
  //   (route) => true,
  // );
}

void showFlutterNotification(RemoteMessage message) {
  final String combinedPayload =
      '${message.data['orderId']}_${message.data['senderId']}_${message.data['receiverId']}';
  final RemoteNotification? notification = message.notification;
  final AndroidNotification? android = message.notification?.android;
  final AppleNotification? iOS = message.notification?.apple;
  if (notification != null && (android != null || iOS != null) && !kIsWeb) {
    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          icon: '@drawable/ic_stat_launcher',
        ),
        iOS: const DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
      payload: combinedPayload,
    );
  }
}

/// Initialize the [FlutterLocalNotificationsPlugin] package.
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
