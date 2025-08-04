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
import 'package:lms/features/auth/logic/auth_controller.dart';
import 'package:lms/features/dashboard/logic/providers.dart';
import 'package:lms/gen/assets.gen.dart';
import 'package:lms/generated/l10n.dart';

class ParentLogoutDialog extends ConsumerWidget {
  const ParentLogoutDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final logOutLoading = ref.watch(logoutProvider);
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Gap(50.h),
            Text(
              S.of(context).areYouSure,
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w500,
                color: context.isDarkMode ? Colors.white : Colors.red,
              ),
              textAlign: TextAlign.center,
            ),
            Gap(25.h),
            Row(
              children: [
                Expanded(
                  child: logOutLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : TextButton(
                          onPressed: () {
                            ref
                                .read(logoutProvider.notifier)
                                .logout()
                                .then((val) {
                              if (val == true) {
                                Hive.box(AppConstants.authBox).clear();
                                Box appSettings =
                                    Hive.box(AppConstants.appSettingsBox);
                                appSettings.put(
                                    AppConstants.hasOTPVerified, false);
                                appSettings.put(
                                    AppConstants.hasChoosePlan, false);
                                ref.invalidate(bottomNavigationIndexProvider);
                                context.go(Routes.login);
                              }
                            });
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: const Color(0xffF6F6F6),
                            padding: EdgeInsets.symmetric(vertical: 15.h),
                            // border color
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                color: AppColors.borderColor,
                              ),
                              borderRadius: BorderRadius.circular(54).r,
                            ),
                          ),
                          child: Text(
                            S.of(context).yes,
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.black,
                            ),
                          ),
                        ),
                ),
                Gap(16.w),
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: EdgeInsets.symmetric(vertical: 15.h),
                    ),
                    child: Text(
                      S.of(context).No,
                      style: TextStyle(fontSize: 16.sp, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            Gap(10.h),
          ],
        ),
        Positioned(
          top: -35.h,
          child: Container(
            padding: const EdgeInsets.all(20).r,
            margin: const EdgeInsets.only(right: 14).r,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              // box shadow
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: SvgPicture.asset(
              Assets.svgs.logout,
              colorFilter: const ColorFilter.mode(
                Colors.red,
                BlendMode.srcIn,
              ),
            ),
          ),
        )
      ],
    );
  }
}
