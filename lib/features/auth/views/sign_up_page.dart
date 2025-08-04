import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:lms/core/constants/app_colors.dart';
import 'package:lms/core/utils/extensions.dart';
import 'package:lms/core/widgets/BG.dart';
import 'package:lms/core/widgets/app_localization_section.dart';
import 'package:lms/features/auth/views/widgets/sign_up_form.dart';
import 'package:lms/generated/l10n.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen(
      {super.key, this.isDataFilled = false, this.hasSocialData});
  final bool isDataFilled;
  final Map<String, dynamic>? hasSocialData;

  @override
  Widget build(BuildContext context) {
    return BG(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppLocalizationSection(),
          Gap(20.h),
          _textInfo(context),
          Gap(24.h),
          SignUpFormSection(
            isDataFilled: isDataFilled,
            hasSocialData: hasSocialData,
          ),
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
            S.of(context).createAccount,
            style: context.textTheme.titleLarge!.copyWith(
              color: AppColors.whiteColor,
            ),
          ),
          Gap(12.sp),
          Text(
            S.of(context).createAnAccount,
            style: context.textTheme.bodyLarge!.copyWith(
              color: AppColors.whiteColor,
            ),
          ),
        ],
      ),
    );
  }
}
