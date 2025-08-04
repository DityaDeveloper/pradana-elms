import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:lms/core/constants/app_colors.dart';
import 'package:lms/core/utils/extensions.dart';
import 'package:lms/core/widgets/BG.dart';
import 'package:lms/features/auth/views/widgets/pin_put_field.dart';
import 'package:lms/gen/assets.gen.dart';
import 'package:lms/generated/l10n.dart';

class OTPScreen extends StatelessWidget {
  OTPScreen(
      {super.key,
      this.isParentLogin = false,
      required this.otpCode,
      required this.phoneNumber});
  final String otpCode;
  final String phoneNumber;
  bool? isParentLogin;

  @override
  Widget build(BuildContext context) {
    return BG(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _logoSection(),
          Gap(32.h),
          _textInfo(context),
          Gap(20.h),
          PinPutField(
            otpCode: otpCode,
            phoneNumber: phoneNumber,
            isParentLogin: isParentLogin,
          ),
        ],
      ),
    );
  }

  Padding _logoSection() {
    return Padding(
      padding: const EdgeInsets.all(16).r,
      child: SvgPicture.asset(
        Assets.svgs.logoDark,
        colorFilter: const ColorFilter.mode(
          AppColors.whiteColor,
          BlendMode.srcIn,
        ),
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
            S.of(context).otpVerification,
            style: context.textTheme.titleLarge!.copyWith(
              color: AppColors.whiteColor,
            ),
          ),
          Gap(12.sp),
          Text(
            "${S.of(context).weHaveSent} $phoneNumber",
            style: context.textTheme.bodyLarge!.copyWith(
              color: AppColors.whiteColor,
            ),
          ),
        ],
      ),
    );
  }
}
