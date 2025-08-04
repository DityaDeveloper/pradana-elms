import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lms/app.dart';
import 'package:lms/core/constants/app_constants.dart';
import 'package:lms/core/utils/network_services.dart';
import 'package:lms/features/shop/models/hive_cart_model.dart';
import 'package:lms/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.dumpErrorToConsole(details);
    print('FlutterError.onError: ${details.exception}');
    if (kReleaseMode) exit(1); // Simulate app termination in release mode
  };

  // Setup Firebase Messaging
  await setupFlutterNotifications();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  firebaseMessagingForgroundHandler();

  if (Platform.isIOS) {
    FirebaseMessaging.instance.getAPNSToken().then((value) {
      debugPrint('APNS Token: $value');
    });
  } else {
    // print firebase token
    FirebaseMessaging.instance.getToken().then((value) {
      debugPrint('Firebase Token: $value');
    });
  }

  await Hive.initFlutter();
  await Hive.openBox(AppConstants.authBox);
  await Hive.openBox(AppConstants.appSettingsBox);
  Hive.registerAdapter(HiveCartModelAdapter());
  await Hive.openBox<HiveCartModel>(AppConstants.cartBox);
  // never rotate the screen
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}
