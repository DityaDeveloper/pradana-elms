import 'package:dio/dio.dart';

abstract class ShopRepository {
  Future<Response> getCategory();
  Future<Response> getProduct({required Map<String, dynamic> params});
  Future<Response> storeOrder({required Map<String, dynamic> params});
  Future<Response> getOrderHistory();
}
