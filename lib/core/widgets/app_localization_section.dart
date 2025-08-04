import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:lms/core/constants/app_colors.dart';
import 'package:lms/features/profile/logic/language_controller_hive.dart';

class AppLocalizationSection extends ConsumerWidget {
  const AppLocalizationSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLocale = ref.watch(localeProvider).languageCode;
    return Padding(
      padding: const EdgeInsets.all(16).r,
      child: Row(
        children: [
          Image.asset(
            "assets/pngs/logo.png",
            height: 60.h,
            width: 60.w,
          ),
          const Spacer(),
          Container(
            padding: EdgeInsets.all(8.r),
            decoration: BoxDecoration(
              color: AppColors.primaryLightColor,
              borderRadius: BorderRadius.circular(40.r),
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    ref
                        .read(localeProvider.notifier)
                        .setLocale(const Locale('en'));
                  },
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: currentLocale == 'en'
                          ? AppColors.whiteColor
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(24.r),
                    ),
                    child: Text(
                      "English",
                      style: TextStyle(
                        color: currentLocale == 'en'
                            ? AppColors.primaryColor
                            : AppColors.whiteColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                ),
               // Gap(8.w),
                // GestureDetector(
                //   onTap: () {
                //     ref
                //         .read(localeProvider.notifier)
                //         .setLocale(const Locale('ar'));

                //     // ref
                //     //     .read(localeProvider.notifier)
                //     //     .setLocale(const Locale('ar'));
                //     // Hive.box('appSetting').put('locale', 'ar');
                //   },
                //   child: Container(
                //     padding:
                //         EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                //     decoration: BoxDecoration(
                //       color: currentLocale == 'ar'
                //           ? AppColors.whiteColor
                //           : Colors.transparent,
                //       borderRadius: BorderRadius.circular(24.r),
                //     ),
                //     child: Text(
                //       "عربي",
                //       style: TextStyle(
                //         color: currentLocale == 'ar'
                //             ? AppColors.primaryColor
                //             : AppColors.whiteColor,
                //         fontWeight: FontWeight.w600,
                //         fontSize: 12.sp,
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
