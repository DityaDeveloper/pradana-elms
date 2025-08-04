import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/core/constants/app_colors.dart';
import 'package:lms/core/utils/extensions.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.title,
    this.onPressed,
    this.backgroundColor,
    this.foregroundColor,
  });

  final String title;
  final Function()? onPressed;
  final Color? backgroundColor;
  final Color? foregroundColor;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: backgroundColor ?? Colors.white,
        foregroundColor: foregroundColor ?? AppColors.primaryColor,
        padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 16.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(54.r),
        ),
        minimumSize: Size(double.infinity, 60.h),
      ),
      onPressed: onPressed,
      child: Text(
        title,
        style: context.textTheme.bodyLarge!.copyWith(
          fontWeight: FontWeight.w600,
          color: foregroundColor ?? AppColors.primaryColor,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
