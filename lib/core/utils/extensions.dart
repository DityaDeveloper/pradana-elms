import 'package:flutter/material.dart';

extension TextThemingExtension on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;
}

extension ThemeExtension on BuildContext {
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;

  Color get containerColor => Theme.of(this).colorScheme.surfaceContainerLowest;
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  Color get cardColor => isDarkMode ? const Color(0xff2E2E2E) : Colors.white;
  Color get chipsColor =>
      isDarkMode ? const Color(0xff3D3D3D) : const Color(0xffF6F6F6);
}
