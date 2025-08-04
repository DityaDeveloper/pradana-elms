import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/app_colors.dart';

class AppTheme {
  // Singleton instance
  static final AppTheme _instance = AppTheme._internal();

  factory AppTheme() {
    return _instance;
  }

  AppTheme._internal();

  // Theme Data
  static ThemeData lightTheme = ThemeData.light().copyWith(
    brightness: Brightness.light,
    primaryColor: AppColors.primaryColor,
    colorScheme: _colorScheme,
    textTheme: _lightTextTheme.apply(
      fontFamily: 'Poppins',
      displayColor: Colors.black,
      bodyColor: Colors.black,
    ),
    elevatedButtonTheme: _elevatedButtonTheme,
    inputDecorationTheme: _inputDecorationTheme,
    appBarTheme: _appBarTheme,
    scaffoldBackgroundColor: AppColors.whiteColor,
    // textButtonTheme: _lightTextButtonTheme,
  );

  static ThemeData darkTheme = ThemeData.dark().copyWith(
    brightness: Brightness.dark,
    primaryColor: AppColors.primaryColor,
    colorScheme: _darkColorScheme,
    textTheme: _darkTextTheme.apply(
      fontFamily: 'Poppins',
      displayColor: Colors.white,
      bodyColor: Colors.white,
    ),
    elevatedButtonTheme: _darkElevatedButtonTheme,
    inputDecorationTheme: _darkInputDecorationTheme,
    appBarTheme: _darkAppBarTheme,
    scaffoldBackgroundColor: AppColors.darkScaffoldColor,
    // textButtonTheme: _darkTextButtonTheme,
  );

  // Color Scheme
  static const ColorScheme _colorScheme = ColorScheme.light(
    primary: AppColors.primaryColor,
    // secondary: AppColors.accentColor,
    // onPrimary: Colors.black,
    // onSecondary: Colors.black,
    // onSurface: Colors.black,
    // primaryContainer: AppColors.whiteColor,
    surfaceContainer: Color(0xffF6F6F6),
  );

  static final ColorScheme _darkColorScheme = _colorScheme.copyWith(
    brightness: Brightness.dark,
    // primaryContainer: AppColors.darkPrimaryColor,
    surfaceContainerLowest: AppColors.darkPrimaryColor,
    surfaceContainer: const Color(0xff3D3D3D),
  );

  // Text Theme
  static final TextTheme _lightTextTheme = TextTheme(
    displayLarge: TextStyle(
      fontSize: 96.0.sp,
      fontWeight: FontWeight.bold,
    ),
    titleLarge: TextStyle(
      fontSize: 28.0.sp,
      fontWeight: FontWeight.w600,
    ),
    titleMedium: TextStyle(
      fontSize: 24.0.sp,
      fontWeight: FontWeight.w600,
    ),
    titleSmall: TextStyle(
      fontSize: 20.0.sp,
      fontWeight: FontWeight.w600,
    ),
    bodyLarge: TextStyle(
      fontSize: 16.0.sp,
      fontWeight: FontWeight.w500,
    ),
    bodyMedium: TextStyle(
      fontSize: 14.0.sp,
      fontWeight: FontWeight.w400,
    ),
    bodySmall: TextStyle(
      fontSize: 12.0.sp,
      fontWeight: FontWeight.w400,
    ),
    labelLarge: TextStyle(
      fontSize: 14.0.sp,
      fontWeight: FontWeight.w400,
    ),
  );

  static final TextTheme _darkTextTheme = _lightTextTheme.apply(
    bodyColor: Colors.white,
    displayColor: Colors.white,
  );

  // Elevated Button Theme
  static final ElevatedButtonThemeData _elevatedButtonTheme =
      ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: AppColors.primaryColor,
      textStyle: const TextStyle(fontSize: 16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    ),
  );

  static final ElevatedButtonThemeData _darkElevatedButtonTheme =
      ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.black,
      backgroundColor: AppColors.primaryColor,
      textStyle: const TextStyle(fontSize: 16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    ),
  );

  // Input Decoration Theme
  static final InputDecorationTheme _inputDecorationTheme =
      InputDecorationTheme(
    labelStyle: TextStyle(
      color: AppColors.hintTextColor,
      fontSize: 13.0.sp,
      fontWeight: FontWeight.w500,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.r),
      borderSide: const BorderSide(color: AppColors.borderColor),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.r),
      borderSide: const BorderSide(color: AppColors.borderColor),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.r),
      borderSide: const BorderSide(color: AppColors.primaryColor),
    ),
  );

  static final InputDecorationTheme _darkInputDecorationTheme =
      InputDecorationTheme(
    labelStyle: TextStyle(
      color: AppColors.hintTextColor,
      fontSize: 13.0.sp,
      fontWeight: FontWeight.w500,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.r),
      borderSide: BorderSide(color: AppColors.borderColor.withOpacity(.1)),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.r),
      borderSide: BorderSide(color: AppColors.borderColor.withOpacity(.1)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.r),
      borderSide: const BorderSide(color: AppColors.primaryColor),
    ),
  );

  // AppBar Theme
  static const AppBarTheme _appBarTheme = AppBarTheme(
    color: AppColors.primaryColor,
    iconTheme: IconThemeData(color: Colors.white),
  );

  static final AppBarTheme _darkAppBarTheme =
      _appBarTheme.copyWith(color: Colors.black);

  // Text Button Theme
  // static final TextButtonThemeData _lightTextButtonTheme = TextButtonThemeData(
  //   style: TextButton.styleFrom(
  //     backgroundColor: AppColors.primaryColor,
  //     foregroundColor: Colors.white,
  //     textStyle: const TextStyle(fontSize: 16.0),
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.circular(8.0),
  //     ),
  //   ),
  // );

  // static final TextButtonThemeData _darkTextButtonTheme = TextButtonThemeData(
  //   style: TextButton.styleFrom(
  //     backgroundColor: AppColors.primaryColor,
  //     foregroundColor: Colors.black,
  //     textStyle: const TextStyle(fontSize: 16.0),
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.circular(8.0),
  //     ),
  //   ),
  // );
}
