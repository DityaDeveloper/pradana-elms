// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plan_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$subscriptionPlanHash() => r'20d66d362ce07a24e1692551ddbacb0dbc517102';

/// See also [SubscriptionPlan].
@ProviderFor(SubscriptionPlan)
final subscriptionPlanProvider =
    AutoDisposeAsyncNotifierProvider<SubscriptionPlan, PlanModel>.internal(
  SubscriptionPlan.new,
  name: r'subscriptionPlanProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$subscriptionPlanHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SubscriptionPlan = AutoDisposeAsyncNotifier<PlanModel>;
String _$purchasePlanHash() => r'baccf5dcf8d042ceba013dfdf9469ef4e923d6e2';

/// See also [PurchasePlan].
@ProviderFor(PurchasePlan)
final purchasePlanProvider =
    AutoDisposeNotifierProvider<PurchasePlan, bool>.internal(
  PurchasePlan.new,
  name: r'purchasePlanProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$purchasePlanHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$PurchasePlan = AutoDisposeNotifier<bool>;
String _$courseSubscriptionHash() =>
    r'fa1c3f900803c675a76ceaba02a4726da49ebf3b';

/// See also [CourseSubscription].
@ProviderFor(CourseSubscription)
final courseSubscriptionProvider =
    AutoDisposeNotifierProvider<CourseSubscription, bool>.internal(
  CourseSubscription.new,
  name: r'courseSubscriptionProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$courseSubscriptionHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CourseSubscription = AutoDisposeNotifier<bool>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
