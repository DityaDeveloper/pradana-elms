import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/core/constants/app_colors.dart';
import 'package:lms/gen/assets.gen.dart';

class TeacherBG extends StatelessWidget {
  const TeacherBG({
    super.key,
    required this.child,
    this.bottomNav,
  });

  final Widget child;
  final Widget? bottomNav;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Stack(
            alignment: Alignment.topRight,
            children: [
              Container(
                color: AppColors.primaryColor,
                height: 340.h,
                width: double.infinity,
              ),
              Image.asset(
                Assets.pngs.bg.path,
                // height: 120.h,
                width: 170.w,
                // width: double.infinity,
                // height: 250.h,
                // fit: BoxFit.cover,
                // colorFilter:
                //     const ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),
              )
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 44).h,
            child: child,
          ),
        ],
      ),
      floatingActionButton: bottomNav,
    );
  }
}
