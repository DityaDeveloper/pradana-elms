import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:lms/core/constants/app_colors.dart';
import 'package:lms/core/utils/extensions.dart';
import 'package:lms/core/widgets/common_appBar_with_BG.dart';
import 'package:lms/features/profile/logic/profile_controller.dart';
import 'package:lms/gen/assets.gen.dart';
import '../../../../generated/l10n.dart';

class NotificationScreen extends ConsumerStatefulWidget {
  const NotificationScreen({super.key});

  @override
  ConsumerState<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends ConsumerState<NotificationScreen> {
  StreamSubscription<RemoteMessage>? _firebaseSubscription;
  @override
  void initState() {
    super.initState();
    // firebase on message refresh notification api
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _firebaseSubscription = FirebaseMessaging.onMessage.listen((event) {
        ref.invalidate(notificationProvider);
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
    return Scaffold(
      backgroundColor:
          context.isDarkMode ? AppColors.darkScaffoldColor : Colors.white,
      body: Column(
        children: [
          _headerSection(),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(top: 10.h),
              child: ref.watch(notificationProvider).when(
                    data: (data) {
                      return data == null
                          ? Center(
                              child: Text(S.of(context).noNotificationfound),
                            )
                          : Column(
                              children: List.generate(
                                data.length,
                                (index) {
                                  return _notificationCard(
                                    isSeen: data[index].isSeen ?? false,
                                    title: data[index].content ?? "",
                                    date: data[index].createdAt ?? "",
                                    time: data[index].createdAtHuman ?? "",
                                    onTap: () {
                                      ref.read(
                                        readNotificationProvider(
                                          notificationId: data[index].id ?? 0,
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            );
                    },
                    loading: () => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    error: (error, stack) => Center(
                      child: Text(
                        error.toString(),
                      ),
                    ),
                  ),
            ),
          ),
        ],
      ),
    );
  }

  _headerSection() {
    return CommonAppbarWithBg(
      child: Row(
        children: [
          Text(
            S.of(context).notifications,
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  _notificationCard({
    required bool isSeen,
    required String title,
    required String date,
    required String time,
    Function()? onTap,
  }) {
    return InkWell(
      onTap: () {
        onTap?.call();
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: !isSeen
              ? const Color(0xffF0F8FF)
                  .withOpacity(context.isDarkMode ? 0.1 : 1)
              : context.cardColor,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10).r,
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    height: 40.r,
                    width: 40.r,
                    padding: const EdgeInsets.all(6).r,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      border: Border.all(
                        color: AppColors.borderColor,
                        width: 0.5,
                      ),
                    ),
                    child: SvgPicture.asset(
                      Assets.svgs.logoDark,
                    ),
                  ),
                  Gap(8.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight:
                                !isSeen ? FontWeight.w600 : FontWeight.w500,
                          ),
                        ),
                        Gap(6.h),
                        Row(
                          children: [
                            Text(
                              date,
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: const Color(0xff6D6D6D),
                              ),
                            ),
                            Gap(6.w),
                            Container(
                              height: 4.r,
                              width: 4.r,
                              padding: const EdgeInsets.all(6).r,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xff9CA3AF),
                              ),
                            ),
                            Gap(6.w),
                            Text(
                              time,
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: const Color(0xff6D6D6D),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  !isSeen
                      ? Container(
                          height: 8.r,
                          width: 8.r,
                          padding: const EdgeInsets.all(6).r,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.primaryColor,
                          ),
                        )
                      : const SizedBox()
                ],
              ),
              const Divider(
                color: AppColors.borderColor,
                thickness: 0.5,
              )
            ],
          ),
        ),
      ),
    );
  }
}
