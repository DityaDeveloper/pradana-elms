// API service implementation
// import 'package:dio/dio.dart';

// class AuthService {
//   final Dio _dio;

//   AuthService(this._dio);

//   Future<Response> login(String email, String password) async {
//     try {
//       final response = await _dio.post(
//         '/auth/login',
//         data: {'email': email, 'password': password},
//       );
//       return response;
//     } on DioError catch (e) {
//       throw Exception('Failed to login: ${e.response?.data['message']}');
//     }
//   }

//   Future<Response> signUp(String email, String password, String name) async {
//     try {
//       final response = await _dio.post(
//         '/auth/signup',
//         data: {
//           'email': email,
//           'password': password,
//           'name': name,
//         },
//       );
//       return response;
//     } on DioError catch (e) {
//       throw Exception('Failed to sign up: ${e.response?.data['message']}');
//     }
//   }

//   Future<Response> refreshToken(String token) async {
//     try {
//       final response = await _dio.post(
//         '/auth/refresh-token',
//         data: {'token': token},
//       );
//       return response;
//     } on DioError catch (e) {
//       throw Exception('Failed to refresh token: ${e.response?.data['message']}');
//     }
//   }
// }
