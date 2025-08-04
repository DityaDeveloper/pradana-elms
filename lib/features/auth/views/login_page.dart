import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:lms/core/constants/app_colors.dart';
import 'package:lms/core/navigation/app_router.dart';
import 'package:lms/core/utils/extensions.dart';
import 'package:lms/core/widgets/BG.dart';
import 'package:lms/core/widgets/app_localization_section.dart';
import 'package:lms/features/auth/views/widgets/login_form.dart';
import 'package:lms/generated/l10n.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BG(
      bottomWidget: Container(
        height: 72.h,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: context.containerColor,
        ),
        child: Container(
          // color: Colors.blue,
          padding: EdgeInsets.only(bottom: 10.h),
          child: Row(
            children: [
              // Expanded(
              //   child: InkWell(
              //     onTap: () {
              //       context.push(Routes.tour);
              //     },
              //     child: Container(
              //       padding: const EdgeInsets.all(10).r,
              //       alignment: Alignment.center,
              //       decoration: BoxDecoration(
              //         color: context.colorScheme.surfaceContainer,
              //         borderRadius: BorderRadius.circular(48.r),
              //       ),
              //       child: Text(S.of(context).tour),
              //     ),
              //   ),
              // ),
              Gap(16.w),
              Expanded(
                child: InkWell(
                  onTap: () {
                    context.push(Routes.shopScreen);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10).r,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: context.colorScheme.surfaceContainer,
                      borderRadius: BorderRadius.circular(48.r),
                    ),
                    child: Text(S.of(context).shop),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppLocalizationSection(),
          Gap(20.h),
          _textInfo(context),
          Gap(24.h),
          const LoginFormSection(),
        ],
      ),
    );
  }

  Padding _textInfo(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.of(context).loginToYrAccount,
            style: context.textTheme.titleLarge!.copyWith(
              color: AppColors.whiteColor,
            ),
          ),
          Gap(12.sp),
          Text(
            S.of(context).enterCredentialsToA,
            style: context.textTheme.bodyLarge!.copyWith(
              color: AppColors.whiteColor,
            ),
          ),
        ],
      ),
    );
  }
}
