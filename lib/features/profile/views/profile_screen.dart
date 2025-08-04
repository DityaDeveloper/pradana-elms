import 'dart:math' as math;

import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
import 'package:lms/core/widgets/BG.dart';
import 'package:lms/features/profile/logic/profile_controller.dart';
import 'package:lms/features/profile/views/widgets/logout_dialog.dart';
import 'package:lms/gen/assets.gen.dart';
import 'package:lms/services/local_storage_service.dart';

import '../../../generated/l10n.dart';
import '../logic/language_controller_hive.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BG(
      child: ValueListenableBuilder(
          valueListenable: Hive.box(AppConstants.authBox).listenable(),
          builder: (context, box, _) {
            final isAuth =
                box.get(AppConstants.authToken, defaultValue: null) == null
                    ? false
                    : true;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gap(30.h),
                isAuth ? const _LogoutSection() : SizedBox(height: 20.h),
                Gap(40.h),
                const _ProfileInfoSection(),
                Container(
                  height: 8.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: context.chipsColor,
                  ),
                ),
                _OthersSection(isAuth: isAuth),
              ],
            );
          }),
    );
  }
}

class _OthersSection extends ConsumerWidget {
  final bool isAuth;
  const _OthersSection({required this.isAuth});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLocale = ref.watch(localeProvider).languageCode;

    return Expanded(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16).r,
        decoration: BoxDecoration(
          color: context.containerColor,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              isAuth
                  ? Column(
                      children: [
                        _CustomButton(
                          iconPath: "assets/pngs/book-saved.png",
                          title: S.of(context).myCourses,
                          onTap: () {
                            context.push(Routes.myCourses);
                          },
                        ),
                        Gap(12.h),
                        _CustomButton(
                          iconPath: "assets/pngs/bag-timer.png",
                          title: S.of(context).orderHistory,
                          onTap: () {
                            context.push(Routes.orderHistory);
                          },
                        ),
                      ],
                    )
                  : const SizedBox.shrink(),
              Gap(12.h),
              // _CustomButton(
              //   iconPath: "assets/pngs/translate.png",
              //   title: S.of(context).language,
              //   widget: Container(
              //     padding: EdgeInsets.all(8.r),
              //     decoration: BoxDecoration(
              //       color: AppColors.primaryLightColor,
              //       borderRadius: BorderRadius.circular(40.r),
              //     ),
              //     child: Row(
              //       children: [
              //         GestureDetector(
              //           onTap: () {
              //             ref
              //                 .read(localeProvider.notifier)
              //                 .setLocale(const Locale('en'));
              //           },
              //           child: Container(
              //             padding: EdgeInsets.symmetric(
              //                 horizontal: 8.w, vertical: 4.h),
              //             decoration: BoxDecoration(
              //               color: currentLocale == 'en'
              //                   ? AppColors.whiteColor
              //                   : Colors.transparent,
              //               borderRadius: BorderRadius.circular(24.r),
              //             ),
              //             child: Text(
              //               "English",
              //               style: TextStyle(
              //                 color: currentLocale == 'en'
              //                     ? AppColors.primaryColor
              //                     : AppColors.whiteColor,
              //                 fontWeight: FontWeight.w600,
              //                 fontSize: 12.sp,
              //               ),
              //             ),
              //           ),
              //         ),
              //         Gap(8.w),
              //         GestureDetector(
              //           onTap: () {
              //             ref
              //                 .read(localeProvider.notifier)
              //                 .setLocale(const Locale('ar'));

              //             // ref
              //             //     .read(localeProvider.notifier)
              //             //     .setLocale(const Locale('ar'));
              //             // Hive.box('appSetting').put('locale', 'ar');
              //           },
              //           child: Container(
              //             padding: EdgeInsets.symmetric(
              //                 horizontal: 8.w, vertical: 4.h),
              //             decoration: BoxDecoration(
              //               color: currentLocale == 'ar'
              //                   ? AppColors.whiteColor
              //                   : Colors.transparent,
              //               borderRadius: BorderRadius.circular(24.r),
              //             ),
              //             child: Text(
              //               "عربي",
              //               style: TextStyle(
              //                 color: currentLocale == 'ar'
              //                     ? AppColors.primaryColor
              //                     : AppColors.whiteColor,
              //                 fontWeight: FontWeight.w600,
              //                 fontSize: 12.sp,
              //               ),
              //             ),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              Gap(12.h),
              Stack(
                children: [
                  _CustomButton(
                    iconPath: "assets/pngs/theme.png",
                    title: S.of(context).theme,
                  ),
                  Positioned(
                    top: 5.h,
                    right: currentLocale == 'ar' ? null : 16.w,
                    left: currentLocale == 'ar' ? 16.w : null,
                    child: ValueListenableBuilder(
                      valueListenable:
                          Hive.box(AppConstants.appSettingsBox).listenable(),
                      builder: (context, box, _) {
                        final bool isDarkTheme = box
                            .get(AppConstants.isDarkTheme, defaultValue: false);
                        return AnimatedToggleSwitch<bool>.dual(
                          current: isDarkTheme,
                          first: false,
                          second: true,
                          style: ToggleStyle(
                            backgroundColor: context.chipsColor,
                            borderColor: AppColors.borderColor.withOpacity(0.5),
                          ),
                          onChanged: (value) =>
                              LocalStorageService().setAppTheme(value),
                          styleBuilder: (b) => ToggleStyle(
                            indicatorColor: b
                                ? AppColors.primaryColor
                                : AppColors.whiteColor,
                          ),
                          iconBuilder: (value) => value
                              ? const Icon(
                                  Icons.dark_mode,
                                  color: Colors.white,
                                )
                              : const Icon(
                                  Icons.light_mode,
                                  color: AppColors.primaryColor,
                                ),
                          textBuilder: (value) => value
                              ? Center(child: Text(S.of(context).light))
                              : Center(child: Text(S.of(context).dark)),
                        );
                      },
                    ),
                  ),
                ],
              ),
              Gap(12.h),
              isAuth
                  ? ref.watch(notificationProvider).when(
                        data: (list) {
                          return _CustomButton(
                            isNotification: list != null &&
                                    list.every((element) =>
                                            element.isSeen == true) ==
                                        true
                                ? false
                                : true,
                            iconPath: "assets/pngs/notification.png",
                            title: S.of(context).notifications,
                            onTap: () {
                              context.push(Routes.notification);
                            },
                          );
                        },
                        error: (error, stackTrace) {
                          return const SizedBox();
                        },
                        loading: () => _CustomButton(
                          iconPath: "assets/pngs/notification.png",
                          title: S.of(context).notifications,
                          onTap: () {
                            context.push(Routes.notification);
                          },
                        ),
                      )
                  : const SizedBox(),
              Gap(12.h),
              isAuth
                  ? _CustomButton(
                      iconPath: "assets/pngs/map.png",
                      title: S.of(context).manageAddress,
                      onTap: () {
                        context.push(Routes.manageAddress);
                      },
                    )
                  : const SizedBox(),
              Gap(12.h),
              Text(
                S.of(context).supportlegals.toUpperCase(),
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xff888888),
                ),
              ),
              isAuth
                  ? Column(
                      children: [
                        Gap(12.h),
                        _CustomButton(
                          iconPath: "assets/pngs/support.png",
                          title: S.of(context).emergencySupport,
                          onTap: () {
                            context.push(Routes.emergencySupport);
                          },
                        ),
                      ],
                    )
                  : const SizedBox.shrink(),
              Gap(12.h),
              _CustomButton(
                iconPath: "assets/pngs/faq.png",
                title: S.of(context).fAQs,
                onTap: () {
                  context.push(Routes.faqs);
                },
              ),
              Gap(100.h),
            ],
          ),
        ),
      ),
    );
  }
}

class _CustomButton extends StatelessWidget {
  const _CustomButton({
    required this.iconPath,
    required this.title,
    this.widget,
    this.onTap,
    this.isNotification = false,
  });
  final bool isNotification;
  final String iconPath;
  final String title;
  final Widget? widget;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.all(16).r,
      decoration: BoxDecoration(
        color: context.cardColor,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: context.isDarkMode
                ? AppColors.whiteColor.withOpacity(0.08)
                : Colors.black.withOpacity(0.08),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20.r),
          child: Padding(
            padding: const EdgeInsets.all(16).r,
            child: Row(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Image.asset(
                      iconPath,
                      height: 24.r,
                      width: 24.r,
                      fit: BoxFit.cover,
                      color: AppColors.primaryColor,
                    ),
                    isNotification == true
                        ? Positioned(
                            right: -3,
                            top: -3,
                            child: Container(
                              height: 12.r,
                              width: 12.r,
                              padding: const EdgeInsets.all(6).r,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.red,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 1.5,
                                ),
                              ),
                            ),
                          )
                        : const SizedBox(),
                  ],
                ),
                Gap(16.w),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                widget ??
                    Transform(
                      alignment: Alignment.center,
                      transform:
                          Localizations.localeOf(context).languageCode == 'ar'
                              ? Matrix4.rotationY(math.pi)
                              : Matrix4.identity(),
                      child: Image.asset("assets/pngs/arrow_right.png"),
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ProfileInfoSection extends StatelessWidget {
  const _ProfileInfoSection();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: Hive.box(AppConstants.authBox).listenable(),
        builder: (context, box, _) {
          final isAuth =
              box.get(AppConstants.authToken, defaultValue: null) == null
                  ? false
                  : true;
          return Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: context.containerColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.r),
                topRight: Radius.circular(20.r),
              ),
            ),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  top: -95.h,
                  left: 0,
                  child: Container(
                    height: 155.r,
                    width: 155.r,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: context.cardColor,
                    ),
                    padding: const EdgeInsets.all(12).r,
                    child: Stack(
                      children: [
                        Container(
                          height: 125.r,
                          width: 125.r,
                          clipBehavior: Clip.hardEdge,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey,
                          ),
                          child: const Icon(Icons.person, size: 50),
                          // isAuth
                          //     ? CachedNetworkImage(
                          //         imageUrl: box.get(AppConstants.userData,
                          //                 defaultValue:
                          //                     null)?['profile_picture'] ??
                          //             '',
                          //         fit: BoxFit.cover,
                          //       )
                          //     : const Icon(Icons.person, size: 50),
                        ),
                        Positioned(
                          bottom: 10,
                          right: 0,
                          child: Container(
                            // height: 35.r,
                            // width: 35.r,
                            padding: const EdgeInsets.all(4).r,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.primaryColor,
                                border: Border.all(
                                  color: Colors.white,
                                )),
                            child: SvgPicture.asset(Assets.svgs.crown,
                                height: 16.r, width: 16.r),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                isAuth
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Gap(60.h),
                          Text(
                            box.get(AppConstants.userData,
                                    defaultValue: null)?['name'] ??
                                '',
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Gap(5.h),
                          Text(
                            box.get(AppConstants.userData,
                                    defaultValue: null)?['email'] ??
                                '',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Gap(10.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Text(
                                      box.get(AppConstants.academinInfoData,
                                              defaultValue: null)?['grade'] ??
                                          '',
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Gap(5.w),
                                    Container(
                                      height: 6.r,
                                      width: 6.r,
                                      decoration: BoxDecoration(
                                        color: context.chipsColor,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    Gap(5.w),
                                    Expanded(
                                      child: Text(
                                        box.get(AppConstants.academinInfoData,
                                                defaultValue:
                                                    null)?['school_type'] ??
                                            '',
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  context.push(Routes.myProfile);
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 12.r, vertical: 4.r),
                                  decoration: BoxDecoration(
                                    color: context.chipsColor,
                                    borderRadius: BorderRadius.circular(14.r),
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        S.of(context).viewProfile,
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      Gap(5.w),
                                      Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        size: 14.r,
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                          Gap(10.h),
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Gap(60.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                S.of(context).guestUser,
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  context.go(Routes.login);
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16.r, vertical: 4.r),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.r),
                                  ),
                                ),
                                child: Text(
                                  S.of(context).login,
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.whiteColor,
                                  ),
                                ),
                              )
                            ],
                          ),
                          Gap(5.h),
                        ],
                      ),
              ],
            ),
          );
        });
  }
}

class _LogoutSection extends StatelessWidget {
  const _LogoutSection();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            barrierDismissible: false,
            barrierColor: context.isDarkMode
                ? Colors.white.withOpacity(0.3)
                : Colors.black.withOpacity(0.5),
            builder: (context) => AlertDialog(
              backgroundColor: context.isDarkMode ? Colors.black : Colors.white,
              insetPadding: const EdgeInsets.symmetric(horizontal: 20),
              contentPadding: const EdgeInsets.all(5),
              content: const LogoutDialog(),
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(12).r,
          margin: const EdgeInsets.only(right: 14).r,
          decoration: BoxDecoration(
            color: AppColors.primaryLightColor,
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColors.primaryMoreLightColor,
            ),
          ),
          child: SvgPicture.asset(Assets.svgs.logout),
        ),
      ),
    );
  }
}
