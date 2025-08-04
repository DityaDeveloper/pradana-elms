import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:lms/core/constants/app_colors.dart';
import 'package:lms/core/navigation/app_router.dart';
import 'package:lms/core/utils/extensions.dart';
import 'package:lms/features/home/logic/providers.dart';
import 'package:lms/features/home/models/home_model/course.dart';
import 'package:lms/features/profile/logic/language_controller_hive.dart';
import 'package:lms/gen/assets.gen.dart';
import 'package:lms/generated/l10n.dart';

class SubjectSection extends ConsumerWidget {
  SubjectSection({
    super.key,
    required this.courseList,
  });

  List<Course>? courseList;

// Function to generate a random color
  Color getRandomColor() {
    Random random = Random();
    return Color.fromARGB(
      255, // Fully opaque
      random.nextInt(256), // Red
      random.nextInt(256), // Green
      random.nextInt(256), // Blue
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.only(top: 16, left: 0, bottom: 16).r,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                padding: ref.watch(localeProvider).languageCode == "en"
                    ? const EdgeInsets.only(left: 16).r
                    : const EdgeInsets.only(right: 16).r,
                child: Text(
                  S.of(context).subjects,
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 16).r,
                child: InkWell(
                  onTap: () {
                    context.push(Routes.subjectList);
                  },
                  child: Text(
                    S.of(context).viewAll,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Gap(12.h),
          courseList == null || courseList!.isEmpty
              ? Text(S.of(context).noCourseFound)
              : SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      courseList!.length,
                      (index) => InkWell(
                        onTap: () {
                          if (courseList![index].isLocked == false) {
                            // check is reviewed or not
                            ref.read(isReviewedProvider.notifier).state =
                                courseList![index].isReviewed ?? false;
                            print(
                                "Subject ID: ${ref.read(isReviewedProvider)}");
                            // navigate to subject based teacher screen
                            context.push(
                              Routes.subjectBasedTeacher,
                              extra: {
                                'subjectId': courseList![index].id,
                                'subjectName': courseList![index].title,
                              },
                            );
                          } else {
                            context.push(Routes.singleSubscription,
                                extra: courseList![index]);
                          }
                        },
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        child: Container(
                          width: 120.w,
                          height: 140.h,
                          // padding: const EdgeInsets.all(12).r,
                          margin: ref.watch(localeProvider).languageCode == "en"
                              ? const EdgeInsets.only(left: 12).r
                              : const EdgeInsets.only(right: 12).r,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                            color: getRandomColor().withOpacity(0.2),
                            border: Border.all(
                              color: context.isDarkMode
                                  ? AppColors.darkPrimaryColor
                                  : Colors.white,
                              width: 2,
                            ),
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            clipBehavior: Clip.none,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(12.0).r,
                                child: Column(
                                  children: [
                                    Container(
                                      height: 64.r,
                                      width: 64.r,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(8.r),
                                        color:
                                            getRandomColor().withOpacity(0.2),
                                      ),
                                      // child: Image.asset(
                                      //   "assets/pngs/book1.png",
                                      //   fit: BoxFit.cover,
                                      // ),
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            courseList![index].thumbnail ?? '',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Gap(8.h),
                                    Text(
                                      courseList![index].title ?? '',
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      "${courseList![index].videoCount} ${S.of(context).videos}",
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400,
                                        color: const Color(0xff5D5D5D),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                top: -5,
                                right: -3,
                                child: courseList![index].isLocked == true
                                    ? Container(
                                        decoration: BoxDecoration(
                                          // border radius only left bottom
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(16.r),
                                          ),
                                          color: Colors.white,
                                        ),
                                        padding: const EdgeInsets.all(8).r,
                                        child:
                                            SvgPicture.asset(Assets.svgs.lock),
                                      )
                                    : const SizedBox(),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                )
        ],
      ),
    );
  }
}
