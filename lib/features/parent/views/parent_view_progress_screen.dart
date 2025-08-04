import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:lms/core/constants/app_colors.dart';
import 'package:lms/features/parent/logic/providers.dart';
import 'package:lms/features/parent/models/child_model.dart';
import 'package:lms/features/parent/views/widgets/parent_view_course_outlet_section.dart';
import 'package:lms/features/parent/views/widgets/parent_view_progress_section.dart';
import 'package:lms/features/progress/logic/progress_controller.dart';
import 'package:lms/features/progress/logic/providers.dart';

class ParentViewProgressScreen extends ConsumerWidget {
  const ParentViewProgressScreen({super.key, this.childList});

  final List<ChildModel>? childList;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: ref
          .watch(
            studentProgressProvider(
              ref.watch(selectedChildProvider)?.id ?? 0,
              // change semester id dynamically
              ref.watch(selectedProgressSemesterProvider)?.id ?? 0,
            ),
          )
          .when(
            data: (progress) {
              return SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Gap(60.h),
                    ParentViewProgressSection(
                      overAllProgress: progress?.data?.overallProgress ?? 0,
                      childList: childList,
                      semesterList: progress?.data?.semesters ?? [],
                    ),
                    Gap(40.h),
                    ParentViewCourseOutlet(
                      subjectList: progress?.data?.courses ?? [],
                    ),
                  ],
                ),
              );
            },
            error: (error, stack) => Center(
              child: Text('Error: $error'),
            ),
            loading: () => const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
          ),
    );
  }
}
