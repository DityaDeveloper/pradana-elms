import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:lms/core/constants/app_colors.dart';
import 'package:lms/core/navigation/app_router.dart';
import 'package:lms/core/utils/extensions.dart';
import 'package:lms/core/widgets/BG.dart';
import 'package:lms/core/widgets/custom_button.dart';
import 'package:lms/gen/assets.gen.dart';
import 'package:lms/generated/l10n.dart';

class TourScreen extends StatelessWidget {
  const TourScreen({super.key});

  List<String> infoList(context) => [
        S.of(context).createyourAccount,
        S.of(context).subscribeToPremiumPlan,
        S.of(context).studyRegularly,
        S.of(context).finishYourCourse,
      ];

  @override
  Widget build(BuildContext context) {
    return BG(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16).r,
            child: SvgPicture.asset(
              Assets.svgs.logoDark,
              colorFilter: const ColorFilter.mode(
                AppColors.whiteColor,
                BlendMode.srcIn,
              ),
            ),
          ),
          Gap(32.h),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: context.containerColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.r),
                  topRight: Radius.circular(20.r),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    S.of(context).howItsWork,
                    style: context.textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 20.sp,
                    ),
                  ),
                  Gap(4.h),
                  Text(
                    S.of(context).seeThevideo,
                    style: context.textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: 14.sp,
                    ),
                  ),
                  Gap(12.h),
                  Container(
                    height: 220.h,
                    width: double.infinity,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(15).r,
                    ),
                    child: Assets.pngs.demoThumbnail.image(fit: BoxFit.cover),
                  ),
                  Gap(28.h),
                  ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(0),
                    children: List.generate(
                      infoList(context).length,
                      (index) {
                        return Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("${index + 1}. "),
                                Expanded(
                                  child: Text(infoList(context)[index]),
                                ),
                              ],
                            ),
                            Gap(12.h),
                          ],
                        );
                      },
                    ),
                  ),
                  const Spacer(),
                  CustomButton(
                    onPressed: () {
                      context.push(Routes.dashboard);
                    },
                    title: S.of(context).getStarted,
                    backgroundColor: AppColors.primaryColor,
                    foregroundColor: context.isDarkMode
                        ? AppColors.darkPrimaryColor
                        : AppColors.whiteColor,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
