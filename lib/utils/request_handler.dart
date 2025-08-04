import 'package:dio/dio.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lms/core/constants/app_constants.dart';
import 'package:lms/core/navigation/app_router.dart';
import 'package:lms/core/utils/global_function.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiInterceptors {
  static void addInterceptors(Dio dio) {
    dio.options.connectTimeout = const Duration(seconds: 30);
    dio.options.receiveTimeout = const Duration(seconds: 30);
    dio.options.headers['Accept'] = 'application/json';
    dio.options.headers['Content-Type'] = 'application/json';
    _addLoggerInterceptor(dio);
    _addResponseHandlerInterceptor(dio);
  }

  static void _addLoggerInterceptor(Dio dio) {
    dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
      maxWidth: 90,
    ));
  }

  static void _addResponseHandlerInterceptor(Dio dio) {
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        final authBox = Hive.box(AppConstants.authBox);
        final token = authBox.get(AppConstants.authToken);
        if (token != null) {
          options.headers['Authorization'] = "Bearer $token";
        }
        handler.next(options);
      },
      onResponse: (response, handler) {
        final message = response.data['message'];

        switch (response.statusCode) {
          case 401:
            Box authBox = Hive.box(AppConstants.authBox);
            authBox.delete(AppConstants.authToken);

            GlobalFunction.showCustomSnackbar(
              message: message,
              isSuccess: false,
            );
            // Access the BuildContext
            final context = GlobalFunction.scaffoldMessengerKey.currentContext;
            if (context != null) {
              // Navigate to the login screen using GoRouter
              context.go(Routes.login);
            }
            break;
          case 302:
          case 400:
          case 403:
          case 404:
          case 409:
          case 422:
          case 500:
            GlobalFunction.showCustomSnackbar(
              message: message,
              isSuccess: false,
            );
            break;
          default:
            break;
        }
        handler.next(response); // Forward the response
      },
      onError: (error, handler) {
        if (error.response?.statusCode == 401) {
          _handleUnauthorized();
        } else {
          handleError(error);
        }
        handler.reject(error); // Forward the error
      },
    ));
  }

  static String handleError(DioException exception) {
    String errorMessage;
    switch (exception.type) {
      case DioExceptionType.receiveTimeout:
        errorMessage = 'Receive time out!';
        break;
      case DioExceptionType.sendTimeout:
        errorMessage = 'Send time out!';
        break;
      case DioExceptionType.badResponse:
        errorMessage =
            'Bad response! Error code: ${exception.response?.statusCode}';
        break;
      case DioExceptionType.badCertificate:
        errorMessage = 'Bad Certificate response!';
        break;
      case DioExceptionType.cancel:
        errorMessage = 'Request was cancelled!';
        break;
      case DioExceptionType.connectionError:
        errorMessage = 'Connection error! Please check your internet.';
        break;
      case DioExceptionType.unknown:
        errorMessage = 'An unknown error occurred';
        break;
      default:
        errorMessage = 'An unexpected error occurred';
    }
    GlobalFunction.showCustomSnackbar(
      message: errorMessage,
      isSuccess: false,
    );

    // If you need to navigate based on the error
    final context = GlobalFunction.scaffoldMessengerKey.currentContext;
    if (context != null) {
      // Navigate or perform other context-based actions
    }
    return errorMessage;
  }

  static void _handleUnauthorized() {
    // Show the snackbar
    GlobalFunction.showCustomSnackbar(
      message: 'Unauthorized',
      isSuccess: false,
    );

    // Delete the auth token
    Box authBox = Hive.box(AppConstants.authBox);
    authBox.delete(AppConstants.authToken);

    // Access the BuildContext
    final context = GlobalFunction.scaffoldMessengerKey.currentContext;
    if (context != null) {
      // Navigate to the login screen using GoRouter
      context.go(Routes.login);
    }
  }
}
