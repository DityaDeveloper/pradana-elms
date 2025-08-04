import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lms/core/constants/app_constants.dart';
import 'package:lms/features/auth/data/auth_repository_imp.dart';
import 'package:lms/features/auth/models/privacy_terms_model/privacy_terms_model.dart';
import 'package:lms/features/auth/models/user_model/user_model.dart';
import 'package:lms/features/home/logic/home_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'auth_controller.g.dart';

@riverpod
class Login extends _$Login {
  @override
  bool build() {
    return false;
  }

  Future<UserModel?> login(
      {required String phone,
      required String password,
      required String userType}) async {
    state = true;

    String? fcmToken;

    if (Platform.isIOS) {
      fcmToken = await FirebaseMessaging.instance.getAPNSToken();
    } else {
      fcmToken = await FirebaseMessaging.instance.getToken();
    }

    return await ref
        .read(authRepositoryImpProvider)
        .login(
          phone: phone,
          password: password,
          userType: userType,
          fcmToken: fcmToken ?? "",
        )
        .then((res) {
      if (res.statusCode == 200) {
        final data = res.data['data'];
        Box authBox = Hive.box(AppConstants.authBox);
        Box appSettings = Hive.box(AppConstants.appSettingsBox);
        authBox.put(AppConstants.authToken, data['token']);
        authBox.put(AppConstants.userData, data['user']);
        authBox.put(
            AppConstants.academinInfoData, data['user']['academic_info']);
        if (data['user']['subscription'] != null) {
          authBox.put(AppConstants.isChatEnabled,
              data['user']['subscription']['available_chat']);
        }
        if (data['user']['otp_verified'] == 1) {
          appSettings.put(AppConstants.hasOTPVerified, true);
        }
        if (data['user']['academic_info'] != null) {
          appSettings.put(AppConstants.hasChoosePlan, true);
        }
        if (data['user']['subscription'] != null) {
          appSettings.put(AppConstants.hasSubscription, true);
        }
        // store user settings validation
        // appSettings.put(AppConstants.hasOTPVerified, true);
        // appSettings.put(AppConstants.hasChoosePlan, true);
        ref.invalidate(homeControllerProvider);
        state = false;
        return UserModel.fromMap(res.data);
      } else {
        state = false;
        return null;
      }
    }).catchError((e) {
      print(e);
      state = false;
      return null;
    }).whenComplete(() {
      state = false;
    });
  }
}

@riverpod
class Registration extends _$Registration {
  @override
  bool build() {
    return false;
  }

  Future<UserModel?> registration({required Map<String, dynamic> data}) async {
    try {
      state = true;
      // Create a modifiable copy of the data map
      Map<String, dynamic> requestData = Map<String, dynamic>.from(data);

      String? fcmToken = Platform.isIOS
          ? await FirebaseMessaging.instance.getAPNSToken()
          : await FirebaseMessaging.instance.getToken();
      requestData['fcm_token'] = fcmToken;
    
      print(requestData);

      final response = await ref
          .read(authRepositoryImpProvider)
          .registration(data: requestData);

      if (response.statusCode == 200) {
        final responseData = response.data['data'];
        Box authBox = Hive.box(AppConstants.authBox);
        authBox.put(AppConstants.authToken, responseData['token']);
        authBox.put(AppConstants.userData, responseData['user']);
        ref.invalidate(homeControllerProvider);
        state = false;
        return UserModel.fromMap(response.data);
      } else {
        state = false;
        return null;
      }
    } catch (e, stackTrace) {
      state = false;
      print('Registration error: $e');
      print('Stack trace: $stackTrace');
      return null;
    }
  }
}

@riverpod
class SendOTP extends _$SendOTP {
  @override
  bool build() {
    return false;
  }

  Future<String?> sendOTP({required String phone}) async {
    state = true;
    final response =
        await ref.read(authRepositoryImpProvider).sendOTP(phone: phone);
    if (response.statusCode == 201) {
      state = false;
      return response.data['data']['otp_code'].toString();
    } else {
      state = false;
      return null;
    }
  }
}

@riverpod
class VerifyOTP extends _$VerifyOTP {
  @override
  bool build() {
    return false;
  }

  Future<String?> verifyOTP(
      {required String phone, required String otp}) async {
    state = true;
    final response = await ref
        .read(authRepositoryImpProvider)
        .verifyOTP(phone: phone, otp: otp);
    if (response.statusCode == 200) {
      state = false;
      String? token = response.data['data']['token'];
      return token;
    } else {
      state = false;
      return null;
    }
  }
}

@riverpod
class Logout extends _$Logout {
  @override
  bool build() {
    return false;
  }

  Future<bool> logout() async {
    state = true;
    final response = await ref.read(authRepositoryImpProvider).logOut();
    if (response.statusCode == 200) {
      state = false;
      return true;
    } else {
      state = false;
      return false;
    }
  }
}

@riverpod
class ProfileUpdate extends _$ProfileUpdate {
  @override
  bool build() {
    return false;
  }

  Future<bool> updateProfile({required Map<String, dynamic> data}) async {
    state = true;
    return await ref
        .read(authRepositoryImpProvider)
        .updateProfile(data: data)
        .then((res) {
      if (res.statusCode == 200) {
        Box authBox = Hive.box(AppConstants.authBox);
        authBox.put(AppConstants.userData, res.data["data"]['user']);
        state = false;
        return true;
      } else {
        state = false;
        return false;
      }
    }).catchError((e) {
      state = false;
      return false;
    }).whenComplete(() {
      state = false;
    });
  }
}

@riverpod
class PrivacyTerms extends _$PrivacyTerms {
  @override
  FutureOr<PrivacyTermsModel?> build() {
    return ref.read(authRepositoryImpProvider).privacyPolicy().then((res) {
      if (res.statusCode == 200) {
        final data = PrivacyTermsModel.fromMap(res.data);
        return data;
      }
      return null;
    });
  }
}

@riverpod
class TermsConditon extends _$TermsConditon {
  @override
  FutureOr<PrivacyTermsModel?> build() {
    return ref.read(authRepositoryImpProvider).termsCondition().then((res) {
      if (res.statusCode == 200) {
        final data = PrivacyTermsModel.fromMap(res.data);
        return data;
      }
      return null;
    });
  }
}

@riverpod
class CheckUser extends _$CheckUser {
  @override
  bool build() {
    return false;
  }

  Future<bool> checkUser({required String email}) async {
    state = true;
    return ref
        .read(authRepositoryImpProvider)
        .checkUser(email: email)
        .then((res) {
      if (res.statusCode == 200) {
        state = false;
        bool isUserExist = res.data['data']['status'] as bool;
        return isUserExist;
      } else {
        state = false;
        return false;
      }
    }).catchError((e) {
      state = false;
      return false;
    }).whenComplete(() {
      state = false;
    });
  }
}

@riverpod
class SocialLogin extends _$SocialLogin {
  @override
  bool build() {
    return false;
  }

  Future<UserModel?> socialLogin({required Map<String, dynamic> data}) async {
    state = true;

    String? fcmToken;

    if (Platform.isIOS) {
      fcmToken = await FirebaseMessaging.instance.getAPNSToken();
    } else {
      fcmToken = await FirebaseMessaging.instance.getToken();
    }
    // set fcm token
    data['fcm_token'] = fcmToken;

    return await ref
        .read(authRepositoryImpProvider)
        .socialLogin(data: data)
        .then((res) {
      if (res.statusCode == 200) {
        final data = res.data['data'];
        Box authBox = Hive.box(AppConstants.authBox);
        Box appSettings = Hive.box(AppConstants.appSettingsBox);
        authBox.put(AppConstants.authToken, data['token']);
        authBox.put(AppConstants.userData, data['user']);
        authBox.put(
            AppConstants.academinInfoData, data['user']['academic_info']);
        if (data['user']['subscription'] != null) {
          authBox.put(AppConstants.isChatEnabled,
              data['user']['subscription']['available_chat']);
        }
        if (data['user']['otp_verified'] == 1) {
          appSettings.put(AppConstants.hasOTPVerified, true);
        }
        if (data['user']['academic_info'] != null) {
          appSettings.put(AppConstants.hasChoosePlan, true);
        }
        if (data['user']['subscription'] != null) {
          appSettings.put(AppConstants.hasSubscription, true);
        }
        // store user settings validation
        // appSettings.put(AppConstants.hasOTPVerified, true);
        // appSettings.put(AppConstants.hasChoosePlan, true);
        ref.invalidate(homeControllerProvider);
        state = false;
        return UserModel.fromMap(res.data);
      } else {
        state = false;
        return null;
      }
    }).catchError((e) {
      print(e);
      state = false;
      return null;
    }).whenComplete(() {
      state = false;
    });
  }
}
