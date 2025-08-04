import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GlobalFunction {
  GlobalFunction._();

  static final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  static void showCustomSnackbar({
    required String message,
    required bool isSuccess,
    bool isTop = false,
  }) {
    final snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          16.r,
        ),
      ),
      backgroundColor: isSuccess ? Colors.green : Colors.red,
      dismissDirection:
          isTop ? DismissDirection.startToEnd : DismissDirection.down,
      content: Text(
        message,
        style: TextStyle(fontSize: 12.sp),
      ),
      margin: isTop
          ? EdgeInsets.only(
              bottom: MediaQuery.of(scaffoldMessengerKey.currentState!.context)
                      .size
                      .height -
                  160,
              right: 20,
              left: 20,
            )
          : null,
    );
    // ScaffoldMessenger.of(scaffoldMessengerKey.currentState!.context)
    //   ..hideCurrentSnackBar()
    //   ..showSnackBar(
    //     snackBar,
    //   );
    scaffoldMessengerKey.currentState!
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  static void changeStatusBarTheme({required isDark}) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
      ),
    );
  }

  static ({String text, Color bgColor}) orderStatus(String orderStatus) {
    switch (orderStatus) {
      case 'pending':
        return (text: 'Pending', bgColor: const Color(0xffFFAB00));
      case 'completed':
        return (text: 'Delivered', bgColor: const Color(0xff36b37e));
      case 'cancelled':
        return (text: 'Cancelled', bgColor: const Color(0xffFF5630));
      default:
        return (text: 'Unknown', bgColor: Colors.grey);
    }
  }
}
