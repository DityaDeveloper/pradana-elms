import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lms/core/constants/app_colors.dart';
import 'package:lms/gen/assets.gen.dart';

class CommonAppbarWithBg extends StatelessWidget {
  const CommonAppbarWithBg({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Stack(
            children: [
              Stack(
                alignment: Alignment.topRight,
                children: [
                  Container(
                    color: AppColors.primaryColor,
                    height: 132.h,
                    width: double.infinity,
                  ),
                  Image.asset(
                    Assets.pngs.bg.path,
                    height: 132.h,
                    //  width: 10.w,
                    // width: double.infinity,
                    // height: 250.h,
                    // fit: BoxFit.cover,
                    // colorFilter:
                    //     const ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 56.h,
                  left: 16.w,
                  right: 16.w,
                ),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Transform(
                        alignment: Alignment.center,
                        transform:
                            Localizations.localeOf(context).languageCode == 'ar'
                                ? Matrix4.rotationY(math.pi)
                                : Matrix4.identity(),
                        child: SvgPicture.asset(
                          Assets.svgs.arrowLeft,
                        ),
                      ),
                    ),
                    SizedBox(width: 16.r),
                    Expanded(child: child)
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
