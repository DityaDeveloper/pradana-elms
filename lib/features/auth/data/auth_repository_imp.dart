import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lms/core/constants/app_constants.dart';
import 'package:lms/features/auth/data/auth_repository.dart';
import 'package:lms/utils/api_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_repository_imp.g.dart';

@riverpod
AuthRepositoryImp authRepositoryImp(AuthRepositoryImpRef ref) {
  return AuthRepositoryImp(ref);
}

class AuthRepositoryImp implements AuthRepository {
  final Ref ref;
  AuthRepositoryImp(this.ref);

  @override
  Future<Response> login({
    required String phone,
    required String password,
    required String userType,
    required String fcmToken,
  }) {
    return ref.read(apiClientProvider).post(AppConstants.loginUrl, data: {
      'phone': phone,
      'password': password,
      'user_type': userType,
      'fcm_token': fcmToken,
    });
  }

  @override
  Future<Response> sendOTP({required String phone}) async {
    return ref.read(apiClientProvider).post(AppConstants.sendOTPUrl, data: {
      'phone': phone,
    });
  }

  @override
  Future<Response> verifyOTP({required String phone, required String otp}) {
    return ref.read(apiClientProvider).post(AppConstants.verifyOTPUrl, data: {
      'phone': phone,
      'code': otp,
    });
  }

  @override
  Future<Response> registration({required Map<String, dynamic> data}) {
    return ref
        .read(apiClientProvider)
        .post(AppConstants.registrationUrl, data: data);
  }

  @override
  Future<Response> logOut() {
    return ref.read(apiClientProvider).post(AppConstants.logOutUrl);
  }

  @override
  Future<Response> updateProfile({required Map<String, dynamic> data}) {
    return ref
        .read(apiClientProvider)
        .post(AppConstants.updateProfile, data: FormData.fromMap(data));
  }

  @override
  Future<Response> privacyPolicy() {
    return ref.read(apiClientProvider).get(AppConstants.privacyPolicy);
  }

  @override
  Future<Response> termsCondition() {
    return ref.read(apiClientProvider).get(AppConstants.termsConditon);
  }

  @override
  Future<Response> checkUser({required String email}) {
    return ref
        .read(apiClientProvider)
        .get(AppConstants.checkUser, query: {"email": email});
  }

  @override
  Future<Response> socialLogin({required Map<String, dynamic> data}) {
    return ref
        .read(apiClientProvider)
        .post(AppConstants.socialLogin, data: data);
  }
}
