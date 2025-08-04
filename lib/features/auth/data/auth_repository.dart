import 'package:dio/dio.dart';

abstract class AuthRepository {
  Future<Response> login(
      {required String phone,
      required String password,
      required String userType,
      required String fcmToken});
  Future<Response> sendOTP({required String phone});
  Future<Response> verifyOTP({required String phone, required String otp});
  Future<Response> registration({required Map<String, dynamic> data});
  Future<Response> updateProfile({required Map<String, dynamic> data});
  Future<Response> logOut();

  Future<Response> privacyPolicy();
  Future<Response> termsCondition();

  Future<Response> checkUser({required String email});
  Future<Response> socialLogin({required Map<String, dynamic> data});
}
