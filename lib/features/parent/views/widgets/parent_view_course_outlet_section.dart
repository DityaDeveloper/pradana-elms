import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:lms/core/constants/app_colors.dart';
import 'package:lms/core/navigation/app_router.dart';
import 'package:lms/core/utils/extensions.dart';
import 'package:lms/features/progress/models/progress_model/course.dart';
import 'package:lms/generated/l10n.dart';

class ParentViewCourseOutlet extends ConsumerWidget {
  const ParentViewCourseOutlet({
    super.key,
    required this.subjectList,
  });

  final List<Course> subjectList;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color:
              context.isDarkMode ? context.chipsColor : const Color(0xffF0F8FF),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
          ),
        ),
        child: GridView.custom(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12.r,
            mainAxisSpacing: 12.r,
            mainAxisExtent: 190.h,
          ),
          padding: EdgeInsets.all(16.r),
          childrenDelegate: SliverChildBuilderDelegate(
            childCount: subjectList.length,
            (context, index) {
              return InkWell(
                onTap: () {
                  context.push(Routes.teachers, extra: {
                    'teacherId': subjectList[index].instructorId,
                    'isParentView': true,
                  });
                },
                child: Container(
                  padding: EdgeInsets.all(12.r),
                  decoration: BoxDecoration(
                    color: context.cardColor,
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 56.r,
                        width: 56.r,
                        clipBehavior: Clip.antiAlias,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        child: CachedNetworkImage(
                          imageUrl: subjectList[index].thumbnail ?? '',
                          fit: BoxFit.fill,
                        ),
                      ),
                      Gap(5.h),
                      Text(
                        subjectList[index].title ?? '',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Gap(4.h),
                      Text(
                        S.of(context).lesson,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      _AnimationProgressBar(
                        progressValue:
                            (subjectList[index].courseProgressPercentage ?? 0) /
                                100,
                        progressActiveColor: const Color(0xff0B9AEC),
                      ),
                      Gap(4.h),
                      Text(
                        S.of(context).exam,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      _AnimationProgressBar(
                        progressValue:
                            (subjectList[index].examProgressPercentage ?? 0) /
                                100,
                        progressActiveColor: const Color(0xff05C7B0),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _AnimationProgressBar extends ConsumerStatefulWidget {
  const _AnimationProgressBar(
      {this.progressValue = 0.1, required this.progressActiveColor});

  final double progressValue;
  final Color progressActiveColor;

  @override
  ConsumerState<_AnimationProgressBar> createState() =>
      _AnimationProgressBarState();
}

class _AnimationProgressBarState extends ConsumerState<_AnimationProgressBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this,
        duration:
            Duration(milliseconds: (widget.progressValue * 1000).toInt()));
    _animation =
        Tween(begin: 0.0, end: widget.progressValue).animate(_controller);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Row(
          children: [
            Expanded(
              child: LinearProgressIndicator(
                value: _animation.value,
                backgroundColor: context.isDarkMode
                    ? context.chipsColor
                    : const Color(0xffE7E7E7),
                valueColor: AlwaysStoppedAnimation(widget.progressActiveColor),
                borderRadius: BorderRadius.circular(8.r),
                minHeight: 7.h,
              ),
            ),
            Gap(8.w),
            Text(
              "${(_animation.value * 100).toInt()}%",
              style: TextStyle(
                fontSize: 10.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryColor,
              ),
            ),
          ],
        );
      },
    );
  }
}
