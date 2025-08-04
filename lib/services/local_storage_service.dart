// Service to interact with local storage
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lms/core/constants/app_constants.dart';
import 'package:lms/features/auth/models/user_model/user.dart';

class LocalStorageService {
  // Singleton instance
  static final LocalStorageService _instance = LocalStorageService._internal();

  // Private constructor
  LocalStorageService._internal();

  // Factory constructor
  factory LocalStorageService() => _instance;

  Future<User> getUser() async {
    final data =
        await Hive.box(AppConstants.authBox).get(AppConstants.userData);

    // Convert the data to a Map<String, dynamic>
    if (data != null && data is Map) {
      final Map<String, dynamic> userMap = Map<String, dynamic>.from(data);

      return User.fromMap(userMap);
    } else {
      throw Exception('User data is not of type Map<String, dynamic>');
    }
  }

  void setAppTheme(bool isDark) {
    print(isDark);
    Hive.box(AppConstants.appSettingsBox).put(
      AppConstants.isDarkTheme,
      isDark,
    );
  }
}
