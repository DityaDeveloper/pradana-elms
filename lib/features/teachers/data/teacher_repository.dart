import 'package:dio/dio.dart';

abstract class TeacherRepository {
  Future<Response> getTeachersList(
      {int? pageNumber, int? limit, String? query});
  Future<Response> getTeacherDetails({required int id});
}
