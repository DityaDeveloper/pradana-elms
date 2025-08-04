import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:lms/core/constants/app_constants.dart';
import 'package:lms/features/shop/data/shop_repository.dart';
import 'package:lms/utils/api_client.dart';

part 'shop_repository_imp.g.dart';

@riverpod
ShopRepositoryImp shopRepositoryImp(ShopRepositoryImpRef ref) {
  return ShopRepositoryImp(ref);
}

class ShopRepositoryImp implements ShopRepository {
  final Ref ref;
  ShopRepositoryImp(this.ref);

  @override
  Future<Response> getCategory() {
    return ref.read(apiClientProvider).get(AppConstants.categoryList);
  }

  @override
  Future<Response> getProduct({required Map<String, dynamic> params}) {
    return ref
        .read(apiClientProvider)
        .get(AppConstants.productList, query: params);
  }

  @override
  Future<Response> storeOrder({required Map<String, dynamic> params}) {
    return ref
        .read(apiClientProvider)
        .post(AppConstants.orderStore, data: params);
  }

  @override
  Future<Response> getOrderHistory() {
    return ref.read(apiClientProvider).get(AppConstants.orderList);
  }
}
