import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:lms/core/constants/app_colors.dart';
import 'package:lms/core/navigation/app_router.dart';
import 'package:lms/core/utils/extensions.dart';
import 'package:lms/core/widgets/custom_button.dart';
import 'package:lms/features/exam/views/widgets/numer_text.dart';
import 'package:lms/features/exam/views/widgets/result_progress_widget.dart';
import 'package:lms/features/quiz/models/quiz_result_model.dart';
import 'package:lms/features/semesters/views/widgets/semester_exam.dart';
import 'package:lms/gen/assets.gen.dart';

import '../../../generated/l10n.dart';

class QuizResultScreen extends ConsumerWidget {
  final bool isFromChapter;
  final QuizeResultModel result;
  const QuizResultScreen({
    super.key,
    required this.isFromChapter,
    required this.result,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: !isFromChapter
            ? null
            : AppBar(
                backgroundColor: context.containerColor,
                title: Text(
                  S.of(context).quizeResult,
                  style: context.textTheme.titleSmall,
                ),
                leading: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Transform(
                      alignment: Alignment.center,
                      transform:
                          Localizations.localeOf(context).languageCode == 'ar'
                              ? Matrix4.rotationY(math.pi)
                              : Matrix4.identity(),
                      child: SvgPicture.asset(
                        Assets.svgs.arrowLeft,
                        colorFilter: ColorFilter.mode(
                          context.isDarkMode
                              ? AppColors.whiteColor
                              : AppColors.darkPrimaryColor,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
        body: Center(
          child: Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 56.h),
            padding: EdgeInsets.all(8.r).copyWith(top: 24.h),
            decoration: ShapeDecoration(
              color: context.containerColor,
              shape: RoundedRectangleBorder(
                side: const BorderSide(
                  width: 1,
                  color: Color(0xFFE7E7E7),
                ),
                borderRadius: BorderRadius.circular(24),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _HeaderWidget(result, isFromChapter: isFromChapter),
                _BreakDownWidget(
                  result,
                ),
                Gap(8.h),
                if (!isFromChapter)
                  CustomButton(
                    title: S.of(context).backToDashboard,
                    onPressed: () => GoRouter.of(context).go(Routes.dashboard),
                    backgroundColor: AppColors.primaryColor,
                    foregroundColor: AppColors.whiteColor,
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _HeaderWidget extends StatelessWidget {
  final bool isFromChapter;
  final QuizeResultModel data;
  const _HeaderWidget(
    this.data, {
    required this.isFromChapter,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (!isFromChapter) ...[
          CircleAvatar(
            radius: 40,
            child: SvgPicture.asset(
              Assets.svgs.like,
            ),
          ),
          Gap(20.h),
          Text(
            S.of(context).tHANKYOU,
            style: context.textTheme.bodyLarge?.copyWith(
              height: 0.09,
              letterSpacing: 4,
            ),
          ),
        ],
        Gap(20.h),
        Consumer(builder: (context, ref, _) {
          final title = ref.read(selectedExamTitleProvider);
          return Text(
            title ?? 'N/A',
            style: context.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w500,
              color: const Color(0xFF2E2E2E),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          );
        }),
        Gap(8.h),
        Text(
          data.quizTitle,
          style: context.textTheme.titleMedium,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        Gap(24.h),
      ],
    );
  }
}

class _BreakDownWidget extends StatefulWidget {
  final QuizeResultModel result;
  const _BreakDownWidget(
    this.result,
  );
  @override
  State<_BreakDownWidget> createState() => _BreakDownWidgetState();
}

class _BreakDownWidgetState extends State<_BreakDownWidget> {
  bool isBreakDown = false;
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 5), () {
      setState(() {
        isBreakDown = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      transitionBuilder: (child, animation) => ScaleTransition(
        scale: animation,
        child: child,
      ),
      child: isBreakDown
          ? Container(
              width: double.infinity,
              padding:
                  const EdgeInsets.only(top: 28, left: 8, right: 8, bottom: 8),
              decoration: ShapeDecoration(
                color: context.isDarkMode
                    ? const Color(0xFF2E2E2E)
                    : const Color(0xFFF0F8FF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              child: Column(
                children: [
                  ResultProgress(
                    totalMarks: widget.result.totalMarks,
                    obtainedMarks: widget.result.obtainedMarks,
                  ),
                  Gap(24.h),
                  Text(
                    S.of(context).hereisthebreakdownofyourresults,
                    style: context.textTheme.bodyLarge
                        ?.copyWith(fontWeight: FontWeight.w500),
                  ),
                  Gap(12.h),
                  Container(
                    width: double.infinity,
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 28.h),
                    decoration: ShapeDecoration(
                      color: context.containerColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    child: Column(
                      children: [
                        IntrinsicHeight(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Flexible(
                                flex: 1,
                                fit: FlexFit.tight,
                                child: _BreakDownColumnWidget(
                                  description: S.of(context).totalQuestions,
                                  count: widget.result.totalQuestions,
                                  color: context.isDarkMode
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                              const VerticalDivider(
                                color: Colors.grey,
                                thickness: 1,
                              ),
                              Gap(8.w),
                              Flexible(
                                flex: 1,
                                fit: FlexFit.tight,
                                child: _BreakDownColumnWidget(
                                  description: S.of(context).answeredQuestions,
                                  count: widget.result.totalAnswers,
                                  color: Theme.of(context).primaryColor,
                                ),
                              )
                            ],
                          ),
                        ),
                        Gap(24.h),
                        IntrinsicHeight(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Flexible(
                                flex: 1,
                                fit: FlexFit.tight,
                                child: _BreakDownColumnWidget(
                                  description: S.of(context).skippedQuestions,
                                  count: widget.result.totalSkipped,
                                  color: const Color(0xFFFFAB00),
                                ),
                              ),
                              const VerticalDivider(
                                color: Colors.grey,
                                thickness: 1,
                              ),
                              Gap(8.w),
                              Flexible(
                                flex: 1,
                                fit: FlexFit.tight,
                                child: _BreakDownColumnWidget(
                                  description: S.of(context).incorrectAnswers,
                                  count: widget.result.totalIncorrect,
                                  color: const Color(0xFFFF5630),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          : const SizedBox.shrink(),
    );
  }
}

class _BreakDownColumnWidget extends StatelessWidget {
  final String description;
  final int count;
  final Color color;
  const _BreakDownColumnWidget({
    required this.description,
    required this.count,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        NumberText(
          targetNumber: count,
          style: context.textTheme.titleMedium?.copyWith(color: color),
        ),
        Text(
          description,
          style: context.textTheme.bodySmall,
        ),
      ],
    );
  }
}
