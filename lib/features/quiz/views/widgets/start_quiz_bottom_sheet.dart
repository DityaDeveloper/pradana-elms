import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:lms/core/constants/app_colors.dart';
import 'package:lms/core/navigation/app_router.dart';
import 'package:lms/core/utils/extensions.dart';
import 'package:lms/core/widgets/custom_button.dart';
import 'package:lms/features/exam/logic/exam_providers.dart';
import 'package:lms/features/quiz/logic/quiz_providers.dart';
import 'package:lms/features/semesters/models/chapter_model/quiz.dart';
import 'package:lms/generated/l10n.dart';

class StartQuizBottomSheet extends StatelessWidget {
  final Quiz quiz;
  const StartQuizBottomSheet({
    super.key,
    required this.quiz,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h)
              .copyWith(top: 10.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
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
              Gap(12.h),
              _ExamHeaderWidget(quizModel: quiz),
              Gap(16.h),
              _SummeryWidget(quizModel: quiz),
              Gap(12.h),
              Align(
                alignment: Alignment.centerLeft,
                child: _InstructionColumnWidget(context: context),
              ),
              Gap(20.h),
              Consumer(builder: (context, ref, _) {
                final startExamRrovder = ref.watch(examStartControllerProvider);
                return startExamRrovder.when(
                  data: (data) {
                    return CustomButton(
                      backgroundColor: AppColors.primaryColor,
                      foregroundColor: AppColors.whiteColor,
                      title: S.of(context).startQuiz,
                      onPressed: () => ref
                          .read(quizControllerProvider.notifier)
                          .startQuiz(
                            quizId: quiz.id,
                          )
                          .then((v) {
                        if (v) {
                          if (context.mounted) {
                            GoRouter.of(context)
                                .go(Routes.quizScreen, extra: quiz);
                          }
                        } else {
                          if (context.mounted) {
                            GoRouter.of(context).pop();
                          }
                        }
                      }),
                    );
                  },
                  error: (error, stackTrace) {
                    return CustomButton(
                      backgroundColor: AppColors.primaryColor,
                      foregroundColor: AppColors.whiteColor,
                      title: S.of(context).startQuiz,
                      onPressed: () => ref
                          .read(quizControllerProvider.notifier)
                          .startQuiz(
                            quizId: quiz.id,
                          )
                          .then((v) {
                        if (v) {
                          Future.delayed(
                            const Duration(milliseconds: 1000),
                          );
                          if (context.mounted) {
                            GoRouter.of(context)
                                .go(Routes.examScreen, extra: quiz);
                          }
                        }
                      }),
                    );
                  },
                  loading: () => SizedBox(
                    height: 60.h,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      child: const CircularProgressIndicator(),
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
        Positioned(
          top: 5.h,
          right: 5.w,
          child: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.cancel_outlined,
              size: 28.sp,
            ),
          ),
        ),
      ],
    );
  }
}

class _ExamHeaderWidget extends StatelessWidget {
  const _ExamHeaderWidget({
    required this.quizModel,
  });

  final Quiz quizModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CachedNetworkImage(
          imageUrl: quizModel.media,
          height: 60.r,
          width: 60.r,
        ),
        Gap(12.h),
        Text(
          S.of(context).startYourQuiz,
          style: context.textTheme.titleMedium,
        ),
        Gap(12.h),
        Text(
          quizModel.title,
          textAlign: TextAlign.center,
          style: context.textTheme.bodyLarge?.copyWith(
            color: Theme.of(context).primaryColor,
          ),
        ),
      ],
    );
  }
}

class _SummeryWidget extends StatelessWidget {
  final Quiz quizModel;
  const _SummeryWidget({
    required this.quizModel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.dm),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: const Color(0xFFF6F6F6)),
      child: Column(
        children: [
          ContentRowWidget(
            title: S.of(context).totalQuestions,
            value: quizModel.questionCount.toString(),
          ),
          Gap(12.h),
          ContentRowWidget(
            title: S.of(context).examDuration,
            value: '${quizModel.durationPerQuestion} ${S.of(context).minutes}',
          ),
          Gap(12.h),
          ContentRowWidget(
            title: S.of(context).totalMark,
            value: (quizModel.questionCount * quizModel.markPerQuestion)
                .toString(),
          ),
        ],
      ),
    );
  }
}

class ContentRowWidget extends StatelessWidget {
  final String title;
  final String value;
  const ContentRowWidget({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: context.textTheme.bodyLarge,
        ),
        Text(
          value,
          style: context.textTheme.bodyLarge
              ?.copyWith(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}

class _InstructionColumnWidget extends StatelessWidget {
  const _InstructionColumnWidget({
    required this.context,
  });

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          S.of(context).instructions,
          style: context.textTheme.bodySmall?.copyWith(
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        Gap(6.h),
        Row(
          children: [
            CircleAvatar(
              radius: 2,
              backgroundColor: Theme.of(context).primaryColor,
            ),
            Gap(6.w),
            Text(
              S.of(context).ensureYouHave,
              style: context.textTheme.bodySmall,
            ),
          ],
        ),
        Gap(6.h),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 2,
              backgroundColor: Theme.of(context).primaryColor,
            ),
            Gap(6.w),
            Expanded(
              child: Text(
                S.of(context).carefullyRead,
                overflow: TextOverflow.clip,
                maxLines: 2,
                style: context.textTheme.bodySmall,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
