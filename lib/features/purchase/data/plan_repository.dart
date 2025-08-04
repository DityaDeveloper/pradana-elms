import 'package:dio/dio.dart';

abstract class PlanRepository {
  Future<Response> getPlanList();
  Future<Response> purchasePlan(Map<String, dynamic> queryParameters);
  Future<Response> singleSubscription(Map<String, dynamic> queryParameters);
}
