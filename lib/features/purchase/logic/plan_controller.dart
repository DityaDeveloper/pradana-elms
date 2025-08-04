import 'package:hive_flutter/hive_flutter.dart';
import 'package:lms/core/constants/app_constants.dart';
import 'package:lms/features/purchase/data/plan_repository_imp.dart';
import 'package:lms/features/purchase/models/plan_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'plan_controller.g.dart';

@riverpod
class SubscriptionPlan extends _$SubscriptionPlan {
  @override
  FutureOr<PlanModel> build() async {
    final response = await ref.read(planRepositoryImpProvider).getPlanList();
    if (response.statusCode == 200) {
      return PlanModel.fromJson(response.data);
    } else {
      throw Exception('Failed to fetch plan list');
    }
  }
}

@riverpod
class PurchasePlan extends _$PurchasePlan {
  @override
  bool build() {
    return false;
  }

  Future<bool> purchasePlan(Map<String, dynamic> queryParameters) async {
    state = true;
    try {
      Box authBox = Hive.box(AppConstants.authBox);
      final response = await ref
          .read(planRepositoryImpProvider)
          .purchasePlan(queryParameters);

      if (response.statusCode == 200) {
        final identifier = response.data['data']['identifier'];
        authBox.put(AppConstants.isChatEnabled,
            response.data['data']['subscription']['available_chat']);
        // await ref.read(apiClientProvider).get(
        //     "http://192.168.0.119:8080/paypal/payment/success/$identifier");
        // await ref.read(apiClientProvider).get(
        //     "http://bridgelms.razinsoft.com/paypal/payment/success/$identifier");
        return true;
      } else {
        // Handle specific error codes if necessary
        return false;
      }
    } catch (e) {
      // Optionally log the error or show a message to the user
      print('Error in purchasePlan: $e');
      return false;
    } finally {
      state = false; // Ensure that the loading state is reset
    }
  }
}

@riverpod
class CourseSubscription extends _$CourseSubscription {
  @override
  bool build() {
    return false;
  }

  Future<bool> singleSubscription(
      {required Map<String, dynamic> queryParameters}) async {
    state = true;
    return ref
        .read(planRepositoryImpProvider)
        .singleSubscription(queryParameters)
        .then((res) {
      if (res.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    }).catchError((e) {
      print('Error in singleSubscription: $e');
      return false;
    }).whenComplete(() => state = false);
  }
}
