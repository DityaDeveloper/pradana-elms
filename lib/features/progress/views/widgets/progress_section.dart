import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:lms/core/constants/app_colors.dart';
import 'package:lms/features/progress/logic/providers.dart';
import 'package:lms/features/progress/models/progress_model/semester.dart';
import 'package:lms/gen/assets.gen.dart';
import 'package:lms/generated/l10n.dart';

class ProgressSection extends ConsumerStatefulWidget {
  const ProgressSection({
    super.key,
    this.overAllProgress = 0,
    this.semesterList = const [],
  });

  final int overAllProgress;
  final List<Semester> semesterList;

  @override
  ConsumerState<ProgressSection> createState() => _ProgressSectionState();
}

class _ProgressSectionState extends ConsumerState<ProgressSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1500));
    _animation = Tween(begin: 0.0, end: widget.overAllProgress / 100)
        .animate(_controller);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          S.of(context).progress,
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.whiteColor,
          ),
        ),
        Gap(32.h),
        AnimatedBuilder(
          animation: _animation,
          builder: (context, _) {
            return Stack(
              children: [
                SizedBox(
                  height: 160.h,
                  width: 160.h,
                  child: CircularProgressIndicator(
                    value: _animation.value,
                    backgroundColor: AppColors.primaryLightColor,
                    valueColor: const AlwaysStoppedAnimation<Color>(
                        AppColors.whiteColor),
                    strokeCap: StrokeCap.round,
                    strokeWidth: 18.r,
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  left: 0,
                  bottom: 0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${(_animation.value * 100).toInt()}%",
                        style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        S.of(context).overAllProgress,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                      Gap(8.h),
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) => SemesterBottomSheet(
                              semesterList: widget.semesterList,
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 2)
                              .r,
                          decoration: BoxDecoration(
                            color: AppColors.primaryLightColor,
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                S.of(context).sem,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.whiteColor,
                                ),
                              ),
                              Gap(2.w),
                              SizedBox(
                                height: 14.r,
                                width: 14.r,
                                child: SvgPicture.asset(
                                  Assets.svgs.arrowDown,
                                  colorFilter: const ColorFilter.mode(
                                    Colors.white,
                                    BlendMode.srcIn,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            );
          },
        )
      ],
    );
  }
}

class SemesterBottomSheet extends ConsumerWidget {
  const SemesterBottomSheet({
    super.key,
    required this.semesterList,
  });

  final List<Semester> semesterList;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedProvider = ref.watch(selectedProgressSemesterProvider);
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 6.h,
            width: 75.w,
            margin: const EdgeInsets.symmetric(vertical: 8).r,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6.r),
              color: Colors.black,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 24.h,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(
                semesterList.length,
                (index) => Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                      onTap: () {
                        if (semesterList[index].isLocked == false) {
                          ref
                              .read(selectedProgressSemesterProvider.notifier)
                              .state = semesterList[index];

                          Navigator.pop(context);
                        } else {
                          return;
                        }
                      },
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 16).r,
                              child: Text(
                                semesterList[index].title ?? '',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                  color: semesterList[index].id ==
                                          selectedProvider?.id
                                      ? const Color(0xff0065FF)
                                      : Colors.black,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 16.r,
                            width: 16.r,
                            child: semesterList[index].isLocked == false
                                ? semesterList[index].id == selectedProvider?.id
                                    ? SvgPicture.asset(Assets.svgs.tickCircle)
                                    : const SizedBox()
                                : SvgPicture.asset(Assets.svgs.lock),
                            // child:
                            //     semesterList[index].id == selectedProvider?.id
                            //         ? SvgPicture.asset(Assets.svgs.tickCircle)
                            //         : null,
                          )
                        ],
                      ),
                    ),
                    semesterList.length - 1 == index
                        ? const SizedBox()
                        : const Divider(
                            thickness: 0.5,
                          )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
