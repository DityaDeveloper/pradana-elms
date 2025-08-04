import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lms/core/constants/app_colors.dart';
import 'package:lms/core/constants/app_constants.dart';
import 'package:lms/core/navigation/app_router.dart';
import 'package:lms/core/utils/extensions.dart';
import 'package:lms/core/widgets/BG.dart';
import 'package:lms/core/widgets/custom_button.dart';
import 'package:lms/features/common/onboarding/logic/providers.dart';

import '../../../generated/l10n.dart';

class OnboardingScreen extends ConsumerWidget {
  const OnboardingScreen({super.key});

  List<Map<String, dynamic>> onboardingAssets(BuildContext context) {
    return [
      {
        "image": "assets/pngs/ob1.png",
        "title": S.of(context).welcometoYourOnlineLearningJourney,
        "description":
            S.of(context).discovercoursestailoredtoyourneedsandinterests
      },
      {
        "image": "assets/pngs/ob2.png",
        "title": S.of(context).accessPremiumStudyResources,
        "description":
            S.of(context).unlockexclusivecontentwithourpremiumsubscription
      },
      {
        "image": "assets/pngs/ob3.png",
        "title": S.of(context).trackYourProgressAchievements,
        "description":
            S.of(context).monitoryourlearningandcelebrateyourmilestones
      },
      {
        "image": "assets/pngs/ob4.png",
        "title": S.of(context).getCertificatesforCompletedCourses,
        "description":
            S.of(context).showcaseyoursuccesswithofficialcoursecertificates
      },
    ];
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final PageController controller = ref.watch(onBoardingProvider);

    return BG(
      isRoot: false,
      child: Column(
        children: [
          _logoHeader(context),
          Expanded(
            child: PageView.builder(
              controller: controller,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: onboardingAssets(context).length,
              itemBuilder: (context, index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Image.asset(
                        onboardingAssets(context)[index]["image"]!,
                        height: 300.h,
                        width: 300.w,
                      ),
                    ),
                    Expanded(
                        child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 16.w, vertical: 16.h),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.r),
                          topRight: Radius.circular(20.r),
                        ),
                      ),
                      child: Column(
                        children: [
                          Gap(20.h),
                          Text(
                            onboardingAssets(context)[index]["title"]!,
                            style: context.textTheme.titleLarge!
                                .copyWith(color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 16.h),
                          Text(
                            onboardingAssets(context)[index]["description"]!,
                            style: context.textTheme.bodyLarge!
                                .copyWith(color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          const Spacer(),
                          CustomButton(
                            title: index == onboardingAssets(context).length - 1
                                ? S.of(context).getStarted
                                : S.of(context).ext,
                            onPressed: () {
                              if (index ==
                                  onboardingAssets(context).length - 1) {
                                Box appSettingsBox =
                                    Hive.box(AppConstants.appSettingsBox);
                                appSettingsBox.put(
                                    AppConstants.hasViewedOnboarding, true);
                                context.pushReplacement(Routes.login);
                              } else {
                                controller.nextPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );
                              }
                            },
                          )
                        ],
                      ),
                    ))
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Padding _logoHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16).r,
      child: Row(
        children: [
          Image.asset(
            "assets/pngs/logo_dark.png",
            height: 60.h,
            width: 60.w,
          ),
          // SvgPicture.asset(Assets.svgs.logoDark,
          //     colorFilter: const ColorFilter.mode(
          //       AppColors.primaryColor,
          //       BlendMode.srcIn,
          //     )),
          const Spacer(),
          TextButton(
            onPressed: () {
              Box appSettingsBox = Hive.box(AppConstants.appSettingsBox);
              appSettingsBox.put(AppConstants.hasViewedOnboarding, true);
              context.pushReplacement(Routes.login);
            },
            child: Text(
              S.of(context).skip,
              style: context.textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
