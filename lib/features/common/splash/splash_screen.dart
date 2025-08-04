import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lms/core/constants/app_colors.dart';
import 'package:lms/core/constants/app_constants.dart';
import 'package:lms/core/navigation/app_router.dart';
import 'package:lms/features/home/logic/system_setting_controller.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  Animation<double>? _animation;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(systemSettingProvider);
    });
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller)
      ..addStatusListener(navigateToAnother);
    _controller.forward();
  }

  void navigateToAnother(AnimationStatus status) async {
    if (status == AnimationStatus.completed) {
      await Future.delayed(const Duration(milliseconds: 600));
      // Request notification permissions
      // bool permissionGranted = await _requestNotificationPermission();
      await _requestNotificationPermission();

      bool isParentLoggedIn = Hive.box(AppConstants.authBox)
          .get(AppConstants.hasParentLoggedIn, defaultValue: false);

      if (isParentLoggedIn == true) {
        _parentValidation();
      } else {
        _studentValidation();
      }
    }
  }

  void _parentValidation() {
    Box authBox = Hive.box(AppConstants.authBox);
    String? authToken = authBox.get(AppConstants.authToken, defaultValue: null);
    context.go(Routes.childList);
  }

  void _studentValidation() {
    Box authBox = Hive.box(AppConstants.authBox);
    Box appSettings = Hive.box(AppConstants.appSettingsBox);

    bool hasViewedOnboarding =
        appSettings.get(AppConstants.hasViewedOnboarding, defaultValue: false);
    bool hasOTPVerified =
        appSettings.get(AppConstants.hasOTPVerified, defaultValue: false);
    bool hasChoosePlan =
        appSettings.get(AppConstants.hasChoosePlan, defaultValue: false);
    bool hasSubscription =
        appSettings.get(AppConstants.hasSubscription, defaultValue: false);
    String? authToken = authBox.get(AppConstants.authToken, defaultValue: null);
    // String? phone =
    //     authBox.get(AppConstants.userData, defaultValue: null)?['phone'];

    if (!hasViewedOnboarding) {
      context.go(Routes.onboarding);
    } else if (!hasOTPVerified) {
      context.go(Routes.signup, extra: {'isDataFilled': true});
    } else if (!hasChoosePlan || !hasSubscription) {
      context.go(Routes.academicInfo);
    } else {
      context.go(Routes.dashboard);
    }
  }

  Future<bool> _requestNotificationPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized ||
        settings.authorizationStatus == AuthorizationStatus.provisional) {
      print('User granted notification permission');
      return true;
    } else {
      print('User declined or has not accepted notification permission');
      return false;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: AnimatedBuilder(
          animation: _animation!,
          builder: (context, child) {
            return ScaleTransition(scale: _animation!, child: child);
          },
          child: Image.asset(
            "assets/pngs/logo.png",
            width: 120.w,
          ),
        ),
      ),
    );
  }
}
