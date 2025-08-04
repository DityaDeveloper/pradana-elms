import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lms/core/constants/app_colors.dart';
import 'package:lms/gen/assets.gen.dart';

class OrderAppbarWithBg extends StatelessWidget {
  const OrderAppbarWithBg(
      {super.key, required this.child, required this.title});
  final String title;

  final Widget child;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Stack(
            children: [
              SizedBox(
                height: 190.h,
                width: double.infinity,
                child: SvgPicture.asset(Assets.svgs.appbarBg,
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      AppColors.primaryColor,
                      BlendMode.srcIn,
                    )),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 75.h,
                  left: 16.w,
                  right: 16.w,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Transform(
                            alignment: Alignment.center,
                            transform:
                                Localizations.localeOf(context).languageCode ==
                                        'ar'
                                    ? Matrix4.rotationY(math.pi)
                                    : Matrix4.identity(),
                            child: SvgPicture.asset(
                              Assets.svgs.arrowLeft,
                            ),
                          ),
                        ),
                        SizedBox(width: 16.r),
                        Expanded(
                          child: Text(
                            title,
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    child,
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
