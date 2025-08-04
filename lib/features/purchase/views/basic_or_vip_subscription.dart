import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lms/core/constants/app_colors.dart';
import 'package:lms/core/constants/app_constants.dart';
import 'package:lms/core/utils/extensions.dart';
import 'package:lms/core/utils/global_function.dart';
import 'package:lms/core/widgets/BG.dart';
import 'package:lms/features/home/models/home_model/course.dart';
import 'package:lms/features/purchase/logic/plan_controller.dart';
import 'package:lms/features/purchase/logic/provider.dart';
import 'package:lms/features/purchase/views/widgets/currency_widget.dart';
import 'package:lms/features/purchase/views/widgets/subscription_success_dialog.dart';
import 'package:lms/gen/assets.gen.dart';
import 'package:lms/generated/l10n.dart';

class BasicOrVipSubscriptionScreen extends ConsumerStatefulWidget {
  const BasicOrVipSubscriptionScreen({super.key, this.course});
  final Course? course;

  @override
  ConsumerState<BasicOrVipSubscriptionScreen> createState() =>
      _BasicOrVipSubscriptionScreenState();
}

class _BasicOrVipSubscriptionScreenState
    extends ConsumerState<BasicOrVipSubscriptionScreen> {
  int? selectedIndex;
  String? totalAmount;
  // List<String> features = ["Free documents", "Ask teacher chat future"];
  List courseOutline(Course? course) => [
        "${course?.videoCount ?? 0} Videos",
        "${course?.noteCount ?? 0} Notes",
        "${course?.examCount ?? 0} Exams",
      ];

  @override
  Widget build(BuildContext context) {
    final selectedPlan = ref.watch(selectedPlanIdProvider);
    return BG(
      child: Column(
        children: [
          _headerSection(context),
          Gap(40.h),
          ref.watch(subscriptionPlanProvider).when(
                data: (data) {
                  final plans = data.data?.plans;
                  return plans == null || plans.isEmpty == true
                      ? Expanded(
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(16).r,
                            decoration: BoxDecoration(
                              color: context.containerColor,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20.r),
                                topRight: Radius.circular(20.r),
                              ),
                            ),
                            child: const Center(
                              child: Text("No Plan Found"),
                            ),
                          ),
                        )
                      : Expanded(
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(16).r,
                            decoration: BoxDecoration(
                              color: context.containerColor,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20.r),
                                topRight: Radius.circular(20.r),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Gap(15.h),
                                Text(
                                  S.of(context).subscribeToPremiumPlan,
                                  style: TextStyle(
                                    fontSize: 24.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                Gap(20.h),
                                Expanded(
                                  child: ListView.builder(
                                    padding: const EdgeInsets.all(0).r,
                                    itemCount: plans.length,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      final plan = plans[index];
                                      final isVip = plan.isPopular == 1;
                                      final isActive =
                                          ref.watch(selectedPlanIdProvider) ==
                                              plan.id;

                                      return InkWell(
                                        onTap: () {
                                          ref
                                              .read(selectedPlanIdProvider
                                                  .notifier)
                                              .state = plan.id;
                                          setState(() {
                                            selectedIndex = index;
                                            totalAmount = ((double.tryParse(
                                                            plan.price ??
                                                                "0") ??
                                                        0) +
                                                    (double.tryParse(widget
                                                                .course?.price
                                                                .toString() ??
                                                            "0") ??
                                                        0))
                                                .toString();
                                          });
                                        },
                                        child: isVip
                                            ? _vipCart(
                                                context: context,
                                                isActive: isActive,
                                                features: plan.features ?? [],
                                                name: plan.name ?? "",
                                                amount: plan.price ?? "",
                                              )
                                            : _basicCart(
                                                context: context,
                                                isActive: isActive,
                                                features: plan.features ?? [],
                                                name: plan.name ?? "",
                                                amount: plan.price ?? "",
                                              ),
                                      );
                                    },
                                  ),
                                ),
                                Consumer(
                                  builder: (context, ref, child) {
                                    final loading =
                                        ref.watch(purchasePlanProvider);
                                    return loading
                                        ? const Center(
                                            child: CircularProgressIndicator(),
                                          )
                                        : TextButton(
                                            style: TextButton.styleFrom(
                                              backgroundColor:
                                                  AppColors.primaryColor,
                                              foregroundColor:
                                                  AppColors.whiteColor,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 32.w,
                                                  vertical: 16.h),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(54.r),
                                              ),
                                              minimumSize:
                                                  Size(double.infinity, 60.h),
                                            ),
                                            onPressed: () async {
                                              if (selectedPlan == null) {
                                                GlobalFunction
                                                    .showCustomSnackbar(
                                                  message: S
                                                      .of(context)
                                                      .pleasechooseanPlan,
                                                  isSuccess: false,
                                                );
                                              } else {
                                                final queryParameters = {
                                                  "payment_gateway": "knet",
                                                  "plan_id": selectedPlan,
                                                  "course_id": widget.course?.id
                                                };
                                                final res = await ref
                                                    .read(purchasePlanProvider
                                                        .notifier)
                                                    .purchasePlan(
                                                        queryParameters);
                                                if (res == true) {
                                                  Hive.box(AppConstants
                                                          .appSettingsBox)
                                                      .put(
                                                          AppConstants
                                                              .hasChoosePlan,
                                                          true);
                                                  Hive.box(AppConstants
                                                          .appSettingsBox)
                                                      .put(
                                                          AppConstants
                                                              .hasSubscription,
                                                          true);
                                                  showDialog(
                                                    context: context,
                                                    barrierDismissible: false,
                                                    barrierColor: context
                                                            .isDarkMode
                                                        ? Colors.white
                                                            .withOpacity(0.5)
                                                        : Colors.black
                                                            .withOpacity(0.5),
                                                    builder: (context) =>
                                                        AlertDialog(
                                                      insetPadding:
                                                          const EdgeInsets
                                                              .symmetric(
                                                              horizontal: 20),
                                                      contentPadding:
                                                          const EdgeInsets.all(
                                                              5),
                                                      content:
                                                          SubscriptionSuccessDialog(
                                                        planName: plans[selectedIndex!
                                                                    .clamp(
                                                                        0,
                                                                        plans.length -
                                                                            1)]
                                                                .name ??
                                                            "",
                                                      ),
                                                    ),
                                                  );
                                                } else {
                                                  ref.invalidate(
                                                      purchasePlanProvider);
                                                }
                                              }
                                            },
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  S.of(context).pay,
                                                  style: context
                                                      .textTheme.bodySmall!
                                                      .copyWith(
                                                    fontSize: 16.sp,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                Gap(5.w),
                                                CurrencyWidget(
                                                  color: AppColors.whiteColor,
                                                  amount: totalAmount ?? "0",
                                                ),
                                              ],
                                            ),
                                          );
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                },
                error: (e, s) {
                  return Center(child: Text(e.toString()));
                },
                loading: () => const Center(child: CircularProgressIndicator()),
              )
        ],
      ),
    );
  }

  Container _vipCart({
    required BuildContext context,
    bool isActive = false,
    required List<dynamic> features,
    required String name,
    required String amount,
  }) {
    return Container(
      padding: const EdgeInsets.all(16).r,
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16).r,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        border: isActive
            ? Border.all(
                color: const Color(0xff0B9AEC),
                width: 2,
              )
            : Border.all(
                color: AppColors.borderColor,
                width: 2,
              ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  name.toUpperCase(),
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryColor,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
              Gap(8.w),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 3,
                ).r,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Text(
                  S.of(context).mostPopular,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.whiteColor,
                  ),
                ),
              ),
              Gap(8.w),
              Container(
                height: 14.r,
                width: 14.r,
                padding: const EdgeInsets.all(2).r,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: isActive
                        ? const Color(0xff0B9AEC)
                        : AppColors.borderColor,
                    width: 1,
                  ),
                  shape: BoxShape.circle,
                ),
                child: Container(
                  height: 8.r,
                  width: 8.r,
                  decoration: BoxDecoration(
                    color: isActive
                        ? const Color(0xff0B9AEC)
                        : AppColors.borderColor,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
          Gap(8.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(
                    features.length,
                    (index) {
                      return Column(
                        children: [
                          Text(
                            "${index + 1}. ${features[index]}",
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Gap(5.h),
                        ],
                      );
                    },
                  ),
                ),
              ),
              CurrencyWidget(
                amount: amount,
              )
            ],
          ),
          Gap(8.w),
          widget.course == null
              ? const SizedBox()
              : IntrinsicHeight(
                  child: Row(
                    children: [
                      Container(
                        width: 2,
                        color: AppColors.borderColor,
                      ),
                      Gap(5.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.course?.title ?? "",
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primaryColor,
                                letterSpacing: 1.5,
                              ),
                            ),
                            Gap(3.h),
                            Row(
                              children: List.generate(
                                courseOutline(widget.course).length,
                                (index) => Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 6.w, vertical: 1.h),
                                  margin: const EdgeInsets.only(right: 4).r,
                                  decoration: BoxDecoration(
                                    color: context.containerColor,
                                    border: Border.all(
                                        color: AppColors.borderColor),
                                    borderRadius: BorderRadius.circular(12).r,
                                  ),
                                  child: Text(
                                    courseOutline(widget.course)[index],
                                    style:
                                        context.textTheme.bodyMedium!.copyWith(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      CurrencyWidget(
                          amount: widget.course?.price.toString() ?? ''),
                    ],
                  ),
                )
        ],
      ),
    );
  }

  Container _basicCart({
    required BuildContext context,
    bool isActive = false,
    required List<dynamic> features,
    required String name,
    required String amount,
  }) {
    return Container(
      padding: const EdgeInsets.all(16).r,
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16).r,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        border: isActive
            ? Border.all(
                color: const Color(0xff0B9AEC),
                width: 2,
              )
            : Border.all(
                color: AppColors.borderColor,
                width: 2,
              ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  name.toUpperCase(),
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryColor,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
              Gap(8.w),
              Container(
                height: 14.r,
                width: 14.r,
                padding: const EdgeInsets.all(2).r,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: isActive
                        ? const Color(0xff0B9AEC)
                        : AppColors.borderColor,
                    width: 1,
                  ),
                  shape: BoxShape.circle,
                ),
                child: Container(
                  height: 8.r,
                  width: 8.r,
                  decoration: BoxDecoration(
                    color: isActive
                        ? const Color(0xff0B9AEC)
                        : AppColors.borderColor,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
          Gap(8.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(
                    features.length,
                    (index) {
                      return Column(
                        children: [
                          Text(
                            "${index + 1}. ${features[index]}",
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Gap(5.h),
                        ],
                      );
                    },
                  ),
                ),
              ),
              CurrencyWidget(
                amount: amount,
              )
            ],
          ),
          Gap(8.w),
          widget.course == null
              ? const SizedBox()
              : IntrinsicHeight(
                  child: Row(
                    children: [
                      Container(
                        width: 2,
                        color: AppColors.borderColor,
                      ),
                      Gap(5.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.course?.title ?? "",
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primaryColor,
                                letterSpacing: 1.5,
                              ),
                            ),
                            Gap(3.h),
                            Row(
                              children: List.generate(
                                courseOutline(widget.course).length,
                                (index) => Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 6.w, vertical: 1.h),
                                  margin: const EdgeInsets.only(right: 4).r,
                                  decoration: BoxDecoration(
                                    color: context.containerColor,
                                    border: Border.all(
                                        color: AppColors.borderColor),
                                    borderRadius: BorderRadius.circular(12).r,
                                  ),
                                  child: Text(
                                    courseOutline(widget.course)[index],
                                    style:
                                        context.textTheme.bodyMedium!.copyWith(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      CurrencyWidget(
                          amount: widget.course?.price.toString() ?? ''),
                    ],
                  ),
                )
        ],
      ),
    );
  }

  Padding _headerSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16).r,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () {
              context.pop();
            },
            child: Transform(
              alignment: Alignment.center,
              transform: Localizations.localeOf(context).languageCode == 'ar'
                  ? Matrix4.rotationY(math.pi)
                  : Matrix4.identity(),
              child: SvgPicture.asset(
                Assets.svgs.arrowLeft,
              ),
            ),
          ),
          const Spacer(),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: AppColors.whiteColor, width: 10),
            ),
            padding: const EdgeInsets.all(16.0),
            child: SvgPicture.asset(
              Assets.svgs.crown,
              width: 60.h,
              // colorFilter: const ColorFilter.mode(
              //   AppColors.primaryColor,
              //   BlendMode.srcIn,
              // ),
            ),
          ),
          //  Assets.pngs.singleSubIcon.image(height: 100.h),
          const Spacer(),
        ],
      ),
    );
  }
}
