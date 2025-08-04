import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lms/core/constants/app_colors.dart';
import 'package:lms/core/constants/app_constants.dart';
import 'package:lms/core/navigation/app_router.dart';
import 'package:lms/features/progress/logic/progress_controller.dart';
import 'package:lms/features/progress/logic/providers.dart';
import 'package:lms/features/progress/views/widgets/course_outlet_section.dart';
import 'package:lms/features/progress/views/widgets/progress_section.dart';

import '../../../generated/l10n.dart';

class StudentViewProgressScreen extends ConsumerWidget {
  const StudentViewProgressScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: ValueListenableBuilder(
        valueListenable: Hive.box(AppConstants.authBox).listenable(),
        builder: (context, authBox, child) {
          int studentId = 0;
          final isAuth =
              authBox.get(AppConstants.authToken, defaultValue: null) == null
                  ? false
                  : true;

          if (isAuth) {
            studentId =
                authBox.get(AppConstants.userData, defaultValue: 0)?['id'];
          }
          return isAuth
              ? ref
                  .watch(studentProgressProvider(studentId,
                      ref.watch(selectedProgressSemesterProvider)?.id))
                  .when(
                    data: (progress) {
                      return SizedBox(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Gap(60.h),
                            ProgressSection(
                              overAllProgress:
                                  progress?.data?.overallProgress ?? 0,
                              semesterList: progress?.data?.semesters ?? [],
                            ),
                            Gap(40.h),
                            Expanded(
                              child: CourseOutlet(
                                subjectList: progress?.data?.courses ?? [],
                                isCertificateAvailable:
                                    progress?.data?.certificateAvailable ??
                                        false,
                              ),
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
                  )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Text(
                        S.of(context).pleaselogintoviewprogress,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    Gap(20.h),
                    ElevatedButton(
                      onPressed: () {
                        context.push(Routes.login);
                      },
                      child: Text(S.of(context).login),
                    ),
                  ],
                );
        },
      ),
    );
  }
}
