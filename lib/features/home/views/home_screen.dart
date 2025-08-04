import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lms/core/constants/app_colors.dart';
import 'package:lms/core/constants/app_constants.dart';
import 'package:lms/core/navigation/app_router.dart';
import 'package:lms/features/home/logic/home_controller.dart';
import 'package:lms/features/home/views/widgets/homeBG.dart';
import 'package:lms/features/home/views/widgets/slider_section.dart';
import 'package:lms/features/home/views/widgets/subject_section.dart';
import 'package:lms/features/home/views/widgets/techers_section.dart';
import 'package:lms/features/profile/logic/profile_controller.dart';
import 'package:lms/gen/assets.gen.dart';
import 'package:lms/generated/l10n.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  StreamSubscription<RemoteMessage>? _firebaseSubscription;
  @override
  void initState() {
    super.initState();
    // firebase on message refresh notification api
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _firebaseSubscription = FirebaseMessaging.onMessage.listen((event) {
        ref.invalidate(notificationProvider);
        print("notification received");
      });
    });
  }

  @override
  void dispose() {
    _firebaseSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return HomeBG(
      child: RefreshIndicator(
        onRefresh: () {
          ref.invalidate(homeControllerProvider);
          return Future.value();
        },
        child: SingleChildScrollView(
          child: ref.watch(homeControllerProvider).when(
                data: (data) {
                  return Column(
                    children: [
                      _headerSection(context, ref),
                      // Gap(12.h),
                      SliderSection(sliderList: data?.data?.sliders ?? []),
                      SubjectSection(courseList: data?.data?.courses),
                      BestTeacherSection(
                          instructorList: data?.data?.instructors),
                      Gap(30.h),
                    ],
                  );
                },
                error: (error, stackTrace) {
                  return Center(
                    child: Text(
                      error.toString(),
                      style: const TextStyle(
                        color: AppColors.whiteColor,
                      ),
                    ),
                  );
                },
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
        ),
      ),
    );
  }

  Widget _headerSection(BuildContext context, WidgetRef ref) {
    return ValueListenableBuilder(
        valueListenable: Hive.box(AppConstants.authBox).listenable(),
        builder: (context, box, widget) {
          final isAuth =
              box.get(AppConstants.authToken, defaultValue: null) == null
                  ? false
                  : true;
          return Padding(
            padding: const EdgeInsets.all(16).r,
            child: Row(
              children: [
                Image.asset(
                  Assets.pngs.logo.path,
                  height: 58.h,
                  width: 47.w,
                ),
                Gap(20.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isAuth
                            ? "${S.of(context).hello},  ${box.get(AppConstants.userData, defaultValue: null)?['name'] ?? ''}"
                            : "${S.of(context).hello}  Guest",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xffFFFFFF),
                        ),
                      ),
                      Gap(6.h),
                      isAuth
                          ? Row(
                              children: [
                                Text(
                                  "${S.of(context).plan} ${box.get(AppConstants.academinInfoData, defaultValue: null)?['grade'] ?? ''}",
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xffFFFFFF)
                                        .withOpacity(0.75),
                                  ),
                                ),
                                Gap(6.w),
                                Container(
                                  height: 6.r,
                                  width: 6.r,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: const Color(0xffFFFFFF)
                                        .withOpacity(0.5),
                                  ),
                                ),
                                Gap(6.w),
                                Expanded(
                                  child: Text(
                                    "${box.get(AppConstants.academinInfoData, defaultValue: null)?['school_type'] ?? ''}",
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400,
                                      color: const Color(0xffFFFFFF)
                                          .withOpacity(0.75),
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            )
                          : const SizedBox(),
                    ],
                  ),
                ),
                if (isAuth == true) ...[
                  ref.watch(notificationProvider).when(
                        data: (list) {
                          return InkWell(
                            onTap: () {
                              GoRouter.of(context).push(Routes.notification);
                            },
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(12).r,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.primaryColor,
                                    border: Border.all(
                                      color: AppColors.primaryMoreLightColor,
                                    ),
                                  ),
                                  child: SvgPicture.asset(
                                      Assets.svgs.notification),
                                ),
                                list != null &&
                                        list.every(
                                            (element) => element.isSeen == true)
                                    ? const SizedBox()
                                    : Positioned(
                                        right: 3,
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
                                      ),
                              ],
                            ),
                          );
                        },
                        error: (error, stackTrace) {
                          return const SizedBox();
                        },
                        loading: () => Container(
                          padding: const EdgeInsets.all(12).r,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.primaryColor,
                            border: Border.all(
                              color: AppColors.borderColor,
                            ),
                          ),
                          child: SvgPicture.asset(Assets.svgs.notification),
                        ),
                      )
                ]
              ],
            ),
          );
        });
  }
}
