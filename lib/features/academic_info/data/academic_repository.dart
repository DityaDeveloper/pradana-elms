import 'package:dio/dio.dart';

abstract class AcademicRepository {
  Future<Response> getAcademicInfo();
  Future<Response> storeAcademicInfo(Map<String, dynamic> data);
}
