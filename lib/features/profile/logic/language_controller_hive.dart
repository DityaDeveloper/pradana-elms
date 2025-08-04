import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lms/core/constants/app_constants.dart';

class LocaleNotifier extends StateNotifier<Locale> {
  LocaleNotifier() : super(_getInitialLocale());

  // Retrieve the initial locale from Hive or default to English
  static Locale _getInitialLocale() {
    final box = Hive.box(AppConstants.appSettingsBox);
    final localeCode = box.get('locale', defaultValue: 'en');
    return Locale(localeCode);
  }

  void setLocale(Locale locale) {
    state = locale;
    Hive.box(AppConstants.appSettingsBox)
        .put('locale', locale.languageCode); // Save preference
  }
}

final localeProvider = StateNotifierProvider<LocaleNotifier, Locale>((ref) {
  return LocaleNotifier();
});
