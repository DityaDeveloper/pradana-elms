import 'package:dio/dio.dart';

abstract class ProgressRepository {
  Future<Response> getProgressInfo({required int studentId, int? semesterId});

  Future<Response> downloadCertificate(
      {required int studentId, required int semesterId});
}
