import 'dart:math' as math;
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
import 'package:lms/features/teachers/logic/teacher_controller.dart';
import 'package:lms/features/teachers/models/teacher_details_model/rating_counts.dart';
import 'package:lms/features/teachers/models/teacher_details_model/review.dart';
import 'package:lms/gen/assets.gen.dart';
import 'package:lms/generated/l10n.dart';
import 'package:readmore/readmore.dart';
import 'package:visibility_detector/visibility_detector.dart';

class TeacherInfoSection extends ConsumerWidget {
  const TeacherInfoSection({
    super.key,
    required this.teacherId,
    this.isParentView,
  });

  final int teacherId;
  final bool? isParentView;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(teacherDetailsProvider(teacherId: teacherId)).when(
          data: (data) {
            return Column(
              children: [
                profilePic(
                  imageUrl: data!.data!.instructor!.profilePicture,
                  rating: data.data!.instructor!.averageRating.toString(),
                ),
                Gap(8.h),
                nameAndOthers(
                  context: context,
                  name: data.data!.instructor!.name,
                  title: data.data!.instructor!.title,
                  joined: data.data!.instructor!.joiningDate,
                ),
                Gap(12.h),
                subjectAndStudents(
                  subject: data.data!.instructor!.courseCount.toString(),
                  students: data.data!.instructor!.studentCount.toString(),
                  context: context,
                ),
                Gap(16.h),
                aboutTeacher(
                    about: data.data!.instructor!.about, context: context),
                Gap(12.h),
                isParentView == true
                    ? const SizedBox()
                    : subjectSection(
                        context: context,
                        courses: data.data!.courses ?? [],
                        ref: ref,
                      ),
                Gap(12.h),
                RatingAndReviewSection(
                  ratingCounts: data.data!.ratingCounts ?? RatingCounts(),
                  reviews: data.data!.reviews ?? [],
                  avgRating: data.data!.instructor!.averageRating.toString(),
                  totalRated: data.data!.totalRating ?? 0,
                ),
              ],
            );
          },
          error: (error, stackTrace) {
            return Center(
              child: Text(
                stackTrace.toString(),
                style: const TextStyle(
                  color: AppColors.whiteColor,
                ),
              ),
            );
          },
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
        );
  }

  Container subjectSection(
      {required BuildContext context,
      List<Course>? courses,
      required WidgetRef ref}) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(left: 16, right: 16).r,
      padding: const EdgeInsets.all(16).r,
      decoration: BoxDecoration(
        color: context.cardColor,
        borderRadius: BorderRadius.circular(16).r,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.of(context).subjects,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          Gap(12.h),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(courses!.length, (int index) {
                return InkWell(
                  onTap: () {
                    if (courses[index].isLocked == false) {
                      // check is reviewed or not
                      ref.read(isReviewedProvider.notifier).state =
                          courses[index].isReviewed ?? false;
                      // navigate to subject based teacher screen
                      context.push(
                        Routes.subjectBasedTeacher,
                        extra: {
                          'subjectId': courses[index].id,
                          'subjectName': courses[index].title,
                        },
                      );
                    } else {
                      context.push(
                        Routes.singleSubscription,
                        extra: courses[index],
                      );
                    }
                  },
                  child: Stack(
                    children: [
                      Container(
                        // width: MediaQuery.of(context).size.width,
                        width: 140.w,
                        padding: const EdgeInsets.all(10).r,
                        margin: const EdgeInsets.only(right: 8).r,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16).r,
                          // random color programmatically
                          color: Color(math.Random().nextInt(0xffffffff))
                              .withOpacity(0.1),
                        ),
                        child: Column(
                          children: [
                            Container(
                              height: 64.h,
                              width: 64.w,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16).r,
                                color: context.cardColor,
                              ),
                              child: CachedNetworkImage(
                                imageUrl: courses[index].thumbnail ?? '',
                                fit: BoxFit.cover,
                              ),
                            ),
                            Gap(8.h),
                            Text(
                              courses[index].title ?? '',
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Gap(4.h),
                            Text(
                              "${courses[index].videoCount} ${S.of(context).videos}",
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: -2,
                        right: 8,
                        child: courses[index].isLocked == true
                            ? Container(
                                decoration: BoxDecoration(
                                  // border radius only left bottom
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(16.r),
                                  ),
                                  color: Colors.white,
                                ),
                                padding: const EdgeInsets.all(8).r,
                                child: SvgPicture.asset(Assets.svgs.lock),
                              )
                            : const SizedBox(),
                      )
                    ],
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Container aboutTeacher({
    String? about,
    required BuildContext context,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(left: 16, right: 16).r,
      padding: const EdgeInsets.all(16).r,
      decoration: BoxDecoration(
        color: context.cardColor,
        borderRadius: BorderRadius.circular(16).r,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.of(context).aboutTeacher,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          Gap(4.h),
          ReadMoreText(
            about ?? '',
            trimMode: TrimMode.Line,
            trimLines: 5,
            preDataTextStyle: const TextStyle(fontWeight: FontWeight.w500),
            style: TextStyle(color: context.textTheme.bodyLarge?.color),
            colorClickableText: AppColors.primaryColor,
            trimCollapsedText: S.of(context).readMore,
            trimExpandedText: ' ${S.of(context).showLess}',
          ),
        ],
      ),
    );
  }

  Padding subjectAndStudents({
    String? subject,
    String? students,
    required BuildContext context,
  }) {
    return Padding(
      padding: const EdgeInsets.all(16).r,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12).r,
        decoration: BoxDecoration(
          color: context.cardColor,
          borderRadius: BorderRadius.circular(16).r,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: IntrinsicHeight(
          child: Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8).r,
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        Assets.svgs.book,
                        height: 20.h,
                        width: 20.h,
                        colorFilter: ColorFilter.mode(
                          context.textTheme.titleLarge?.color! ?? Colors.black,
                          BlendMode.srcIn,
                        ),
                      ),
                      Gap(8.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            subject ?? "",
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Gap(4.w),
                          Text(S.of(context).subjects),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              VerticalDivider(
                color: Colors.black.withOpacity(0.15),
                thickness: 1,
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8).r,
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        Assets.svgs.people,
                        height: 20.h,
                        width: 20.h,
                        colorFilter: ColorFilter.mode(
                          context.textTheme.titleLarge?.color! ?? Colors.black,
                          BlendMode.srcIn,
                        ),
                      ),
                      Gap(8.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            students ?? "",
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Gap(4.w),
                          Text(S.of(context).students),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget nameAndOthers(
      {required BuildContext context,
      String? name,
      String? title,
      String? joined}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16).r,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            name ?? "",
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          Gap(8.h),
          Text(
            title ?? "",
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          Gap(8.h),
          Text(
            "${S.of(context).joined}: $joined",
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Stack profilePic({String? imageUrl, String? rating}) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          height: 105.h,
          width: 105.w,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white,
              width: 2,
            ),
          ),
          // child: const Icon(Icons.person, color: Colors.white, size: 50),
          child: CachedNetworkImage(
            imageUrl: imageUrl ?? '',
            fit: BoxFit.cover,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2).r,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16).r,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Assets.pngs.star.image(width: 12.w),
              Gap(4.w),
              Text(
                rating ?? "0.0",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class RatingAndReviewSection extends StatefulWidget {
  const RatingAndReviewSection({
    super.key,
    required this.ratingCounts,
    required this.reviews,
    required this.avgRating,
    required this.totalRated,
  });

  final RatingCounts ratingCounts;
  final List<Review> reviews;
  final String avgRating;
  final int totalRated;

  @override
  State<RatingAndReviewSection> createState() => _RatingAndReviewSectionState();
}

class _RatingAndReviewSectionState extends State<RatingAndReviewSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1500));
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<int> ratingCount = [
      widget.ratingCounts.rating5 ?? 0,
      widget.ratingCounts.rating4 ?? 0,
      widget.ratingCounts.rating3 ?? 0,
      widget.ratingCounts.rating2 ?? 0,
      widget.ratingCounts.rating1 ?? 0,
    ];
    // Calculate the total number of ratings
    final int totalRatings = ratingCount.fold(0, (sum, count) => sum + count);
    // Calculate fraction for each rating
    final List<double> ratingFractions = ratingCount.map((count) {
      if (totalRatings == 0) return 0.0; // Avoid division by zero
      return count / totalRatings;
    }).toList();
    return VisibilityDetector(
      key: const Key("RatingAndReviewSection"),
      onVisibilityChanged: (info) {
        // if (info.visibleFraction >= 0) {
        //   _controller.forward();
        // }
        if (!mounted) return;
        _controller.forward();
      },
      child: Container(
        color: context.cardColor,
        padding: const EdgeInsets.all(16).r,
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.of(context).ratingAndReviews,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            Gap(20.h),
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        widget.avgRating,
                        style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Row(
                        children: [
                          for (int i = 0; i < 5; i++)
                            Icon(
                              Icons.star,
                              color: const Color(0xffF59E0B),
                              size: 16.r,
                            ),
                        ],
                      ),
                      Text(
                        "(${widget.totalRated})",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                  Gap(15.w),
                  VerticalDivider(
                    color: Colors.black.withOpacity(0.15),
                    thickness: 1,
                  ),
                  Gap(15.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(
                        ratingCount.length,
                        (index) {
                          // Reverse index to align with ratings from 5 to 1
                          int reversedIndex = ratingCount.length - 1 - index;

                          // Get the fraction for the current rating
                          double fraction = ratingFractions[reversedIndex];

                          return Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 10.w,
                                child: Text(
                                  // "${5 - index}",
                                  "${index + 1}",
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Gap(10.w),
                              Expanded(
                                child: Container(
                                  height: 8.h,
                                  width: double.infinity,
                                  margin: const EdgeInsets.only(top: 2).r,
                                  decoration: BoxDecoration(
                                    color: context.chipsColor,
                                    borderRadius: BorderRadius.circular(16).r,
                                  ),
                                  child: AnimatedBuilder(
                                    animation: _animation,
                                    builder: (context, child) {
                                      return FractionallySizedBox(
                                        alignment: Alignment.centerLeft,
                                        widthFactor:
                                            fraction * _animation.value,
                                        child: Container(
                                          height: 8.h,
                                          decoration: BoxDecoration(
                                            color: const Color(0xffF59E0B),
                                            borderRadius:
                                                BorderRadius.circular(16).r,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ).reversed.toList(),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: List.generate(
                widget.reviews.length,
                (index) {
                  return Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(top: 12).r,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: context.chipsColor,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 16)
                              .r,
                          decoration: BoxDecoration(
                            color: context.chipsColor,
                            borderRadius: BorderRadius.circular(8).r,
                          ),
                          child: Row(
                            children: [
                              Container(
                                height: 40.h,
                                width: 40.h,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.grey,
                                ),
                                clipBehavior: Clip.antiAlias,
                                child: CachedNetworkImage(
                                  imageUrl:
                                      widget.reviews[index].profilePicture ??
                                          '',
                                ),
                              ),
                              Gap(12.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.reviews[index].userName ?? '',
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Row(
                                      children: [
                                        for (int i = 0;
                                            i <
                                                (widget.reviews[index].rating ??
                                                        0)
                                                    .toInt();
                                            i++)
                                          Icon(
                                            Icons.star,
                                            color: const Color(0xffF59E0B),
                                            size: 16.r,
                                          ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Gap(10.w),
                              Text(
                                widget.reviews[index].createdAt ?? '',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(16).r,
                          child: Text(
                            widget.reviews[index].comment ?? '',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
