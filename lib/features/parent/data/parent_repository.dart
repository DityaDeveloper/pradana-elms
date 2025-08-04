import 'package:dio/dio.dart';

abstract class ParentRepository {
  Future<Response> getChildList();
}
