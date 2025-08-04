import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lms/core/constants/app_colors.dart';
import 'package:lms/core/constants/app_constants.dart';
import 'package:lms/core/navigation/app_router.dart';
import 'package:lms/features/shop/models/hive_cart_model.dart';
import 'package:lms/gen/assets.gen.dart';

class ShopAppbarWithBg extends StatelessWidget {
  const ShopAppbarWithBg({super.key, required this.child, required this.title});
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
              Stack(
                alignment: Alignment.topRight,
                children: [
                  Container(
                    color: AppColors.primaryColor,
                    height: 190.h,
                    width: double.infinity,
                  ),
                  Image.asset(
                    Assets.pngs.bg.path,
                    height: 190.h,
                    //  width: 10.w,
                    // width: double.infinity,
                    // height: 250.h,
                    // fit: BoxFit.cover,
                    // colorFilter:
                    //     const ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),
                  )
                ],
              ),
              // SizedBox(
              //   height: 190.h,
              //   width: double.infinity,
              //   child: SvgPicture.asset(
              //     Assets.svgs.shopBG,
              //     fit: BoxFit.cover,
              //   ),
              // ),
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
                        InkWell(
                          onTap: () {
                            context.push(Routes.myCart);
                          },
                          child: ValueListenableBuilder(
                            valueListenable:
                                Hive.box<HiveCartModel>(AppConstants.cartBox)
                                    .listenable(),
                            builder: (context, box, _) {
                              return Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  SvgPicture.asset(
                                    Assets.svgs.cart,
                                  ),
                                  box.values.isEmpty
                                      ? const SizedBox()
                                      : Positioned(
                                          top: -10,
                                          right: -8,
                                          child: Container(
                                            padding: const EdgeInsets.all(6).r,
                                            decoration: const BoxDecoration(
                                              color: Colors.red,
                                              shape: BoxShape.circle,
                                            ),
                                            child: Center(
                                              child: Text(
                                                box.values.length.toString(),
                                                style: TextStyle(
                                                  fontSize: 10.sp,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                ],
                              );
                            },
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
