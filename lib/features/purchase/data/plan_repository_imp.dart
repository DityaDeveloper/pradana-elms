import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lms/core/constants/app_constants.dart';
import 'package:lms/features/purchase/data/plan_repository.dart';
import 'package:lms/utils/api_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'plan_repository_imp.g.dart';

@riverpod
PlanRepositoryImp planRepositoryImp(PlanRepositoryImpRef ref) {
  return PlanRepositoryImp(ref);
}

class PlanRepositoryImp implements PlanRepository {
  final Ref ref;
  PlanRepositoryImp(this.ref);

  @override
  Future<Response> getPlanList() {
    return ref.read(apiClientProvider).get(AppConstants.planList);
  }

  @override
  Future<Response> purchasePlan(Map<String, dynamic> queryParameters) {
    return ref
        .read(apiClientProvider)
        .get(AppConstants.purchasePlan, query: queryParameters);
  }

  @override
  Future<Response> singleSubscription(Map<String, dynamic> queryParameters) {
    return ref
        .read(apiClientProvider)
        .get(AppConstants.purchasePlan, query: queryParameters);
  }
}
