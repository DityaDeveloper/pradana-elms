import 'dart:math' as math;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lms/core/constants/app_colors.dart';
import 'package:lms/core/constants/app_constants.dart';
import 'package:lms/core/navigation/app_router.dart';
import 'package:lms/core/utils/extensions.dart';
import 'package:lms/core/utils/global_function.dart';
import 'package:lms/core/widgets/BG.dart';
import 'package:lms/features/dashboard/logic/providers.dart';
import 'package:lms/features/home/logic/home_controller.dart';
import 'package:lms/features/home/models/home_model/course.dart';
import 'package:lms/features/purchase/logic/plan_controller.dart';
import 'package:lms/features/purchase/views/widgets/currency_widget.dart';
import 'package:lms/gen/assets.gen.dart';

import '../../../generated/l10n.dart';

class SingleSubscriptionScreen extends StatelessWidget {
  const SingleSubscriptionScreen({super.key, required this.course});
  final Course course;

  List features(BuildContext context, Course course) => [
        "${course.videoCount} ${S.of(context).videos}",
        "${course.noteCount} ${S.of(context).notes}",
        "${course.examCount} ${S.of(context).exam}",
      ];

  @override
  Widget build(BuildContext context) {
    return BG(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _headerSection(context),
          Gap(40.h),
          Expanded(
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
                    '${S.of(context).subscribeTo} ${course.title ?? ''} ${S.of(context).plan}',
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Gap(20.h),
                  Container(
                    padding: const EdgeInsets.all(16).r,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(
                        color: const Color(0xff0B9AEC),
                        width: 2,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.r)),
                          child: CachedNetworkImage(
                            imageUrl: course.thumbnail ?? '',
                            height: 48.r,
                            width: 48.r,
                            fit: BoxFit.cover,
                            placeholder: (context, url) =>
                                const CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                        Gap(10.h),
                        Text(
                          course.title ?? '',
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryColor,
                            letterSpacing: 1.5,
                          ),
                        ),
                        Gap(8.h),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: List.generate(
                                  features(context, course).length,
                                  (index) {
                                    return Column(
                                      children: [
                                        Text(
                                          "${index + 1}. ${features(context, course)[index]}",
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
                              amount: course.price.toString(),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  const Spacer(),
                  Consumer(builder: (context, ref, _) {
                    final isLoading = ref.watch(courseSubscriptionProvider);
                    return isLoading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: AppColors.primaryColor,
                              foregroundColor: AppColors.whiteColor,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 32.w, vertical: 16.h),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(54.r),
                              ),
                              minimumSize: Size(double.infinity, 60.h),
                            ),
                            onPressed: () {
                              ref
                                  .read(courseSubscriptionProvider.notifier)
                                  .singleSubscription(queryParameters: {
                                'course_id': course.id,
                                "payment_gateway": "knet",
                              }).then((value) {
                                if (value == true) {
                                  ref.invalidate(homeControllerProvider);
                                  // save to local storage
                                  Hive.box(AppConstants.appSettingsBox)
                                      .put(AppConstants.hasChoosePlan, true);
                                  Hive.box(AppConstants.appSettingsBox)
                                      .put(AppConstants.hasSubscription, true);
                                  context.go(Routes.dashboard);
                                  ref
                                      .read(bottomNavigationIndexProvider
                                          .notifier)
                                      .state = 0;
                                  GlobalFunction.showCustomSnackbar(
                                    message: "Successfully Purchased",
                                    isSuccess: true,
                                  );
                                }
                              });
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  S.of(context).pay,
                                  style: context.textTheme.bodySmall!.copyWith(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Gap(5.w),
                                CurrencyWidget(
                                  color: AppColors.whiteColor,
                                  amount: course.price.toString(),
                                ),
                              ],
                            ),
                          );
                  })
                ],
              ),
            ),
          ),
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
                border: Border.all(color: AppColors.whiteColor, width: 10)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset(
                Assets.svgs.crown,
              ),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
