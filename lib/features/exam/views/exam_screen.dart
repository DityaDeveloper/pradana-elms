import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:lms/core/navigation/app_router.dart';
import 'package:lms/core/utils/extensions.dart';
import 'package:lms/core/widgets/custom_button.dart';
import 'package:lms/core/widgets/exam_bg.dart';
import 'package:lms/features/exam/logic/exam_providers.dart';
import 'package:lms/features/exam/logic/exam_question_controller.dart';
import 'package:lms/features/exam/views/widgets/exam_exit_confirmation_dialog.dart';
import 'package:lms/features/exam/views/widgets/exam_option_card.dart';
import 'package:lms/features/exam/views/widgets/exam_timer_widget.dart';
import 'package:lms/features/semesters/models/chapter_model/exam.dart';
import 'package:lms/generated/l10n.dart';

import '../../../core/utils/global_function.dart';

class ExamScreen extends StatelessWidget {
  final Exam examModel;
  const ExamScreen({super.key, required this.examModel});

  @override
  Widget build(BuildContext context) {
    return ExamBG(
      bottomWidget: _ExamBottomSheet(examModel),
      child: Column(
        children: [
          _TitleAndProgressWidget(examModel),
          _QuestionCardWidget(examModel),
        ],
      ),
    );
  }
}

class _ExamBottomSheet extends StatelessWidget {
  final Exam examModel;
  const _ExamBottomSheet(
    this.examModel,
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ExamTimerWidget(
                duration: examModel.duration ?? 0,
                startTimer: (s) {
                  debugPrint('start');
                },
                pauseTimer: (p) {
                  debugPrint('pause');
                },
                onTimerEnded: (e) {
                  debugPrint('ended');
                },
                onTimerChanged: (c) {
                  debugPrint('changed');
                },
              ),
              Text(
                " ${S.of(context).remainigTime}",
                style: context.textTheme.bodyMedium,
              ),
            ],
          ),
          Consumer(builder: (context, ref, _) {
            final questionIndex = ref.watch(questionHandlerControllerProvider);
            return Text(
              '${questionIndex + 1} ${S.of(context).ofT} ${examModel.questionCount}',
              style: context.textTheme.bodyMedium,
            );
          }),
        ],
      ),
    );
  }
}

class _TitleAndProgressWidget extends ConsumerWidget {
  final Exam examModel;
  const _TitleAndProgressWidget(this.examModel);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Row(
          children: [
            IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => ExamExitConfirmationDialog(
                    description: examModel.title ?? 'N/A',
                    onExit: () {
                      ref
                          .refresh(selectedAnswerControllerProvider.notifier)
                          .stream;
                      ref
                          .refresh(questionHandlerControllerProvider.notifier)
                          .stream;
                      GoRouter.of(context).go(Routes.dashboard);
                    },
                  ),
                );
              },
              icon: const Icon(Icons.close),
            ),
            Gap(12.w),
            Expanded(
              child: Text(
                examModel.title ?? 'N/A',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: context.textTheme.titleSmall,
              ),
            ),
          ],
        ),
        Gap(8.h),
        Consumer(builder: (context, ref, _) {
          final questionIndex = ref.watch(questionHandlerControllerProvider);
          double newProgress = questionIndex / (examModel.questionCount!);

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: TweenAnimationBuilder<double>(
                tween: Tween(begin: 0, end: newProgress),
                duration: const Duration(milliseconds: 300),
                builder: (context, progress, child) {
                  return LinearProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                        context.colorScheme.primary),
                    minHeight: 8.h,
                    borderRadius: BorderRadius.circular(8.r),
                    value: progress,
                    color: context.colorScheme.primaryContainer,
                    backgroundColor: const Color(0x3F015B99),
                  );
                }),
          );
        })
      ],
    );
  }
}

class _QuestionCardWidget extends ConsumerStatefulWidget {
  final Exam examModel;
  const _QuestionCardWidget(
    this.examModel,
  );

  @override
  ConsumerState<_QuestionCardWidget> createState() =>
      _QuestionCardWidgetState();
}

class _QuestionCardWidgetState extends ConsumerState<_QuestionCardWidget> {
  bool showAnimation = false;
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 5), () {
      setState(() {
        showAnimation = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final questionListProvider = ref.watch(examStartControllerProvider);

    return questionListProvider.maybeWhen(
      data: (data) {
        final question = data?[ref.watch(questionHandlerControllerProvider)];
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          transitionBuilder: (child, animation) => ScaleTransition(
            scale: animation,
            child: child,
          ),
          child: showAnimation
              ? AnimatedSize(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeInOut,
                  child: Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      shadows: const [
                        BoxShadow(
                          color: Color(0x1E000000),
                          blurRadius: 36,
                          offset: Offset(0, 12),
                          spreadRadius: 0,
                        )
                      ],
                    ),
                    child: Column(
                      children: [
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 500),
                          transitionBuilder: (child, animation) =>
                              FadeTransition(
                            opacity: animation,
                            child: child,
                          ),
                          child: Column(
                            key: ValueKey(question?.id),
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (question?.media != null)
                                Container(
                                  height: 185.h,
                                  margin: EdgeInsets.only(bottom: 11.h),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.r),
                                    image: DecorationImage(
                                      image: CachedNetworkImageProvider(
                                          question!.media!),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              Text(
                                question!.question,
                                maxLines: 1,
                                style: context.textTheme.titleSmall
                                    ?.copyWith(fontSize: 18.sp),
                              ),
                              Gap(12.h),
                              Column(
                                children: List.generate(
                                  question.options.length,
                                  (index) => Padding(
                                    padding: const EdgeInsets.only(bottom: 8),
                                    child: ExamOptionCard(
                                      isMultiChoice: question.questionType ==
                                          'multiple_choice',
                                      option: question.options[index].text,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Flexible(
                              flex: 1,
                              child: CustomButton(
                                title: S.of(context).skip,
                                foregroundColor: Colors.black.withOpacity(0.7),
                                onPressed: () => _action(
                                  isSkip: true,
                                  context: context,
                                  ref: ref,
                                  questionID: question.id,
                                  isSubmit: false,
                                  isMultiChoice: question.questionType ==
                                      'multiple_choice',
                                ),
                              ),
                            ),
                            Gap(16.w),
                            Flexible(
                              flex: 2,
                              fit: FlexFit.tight,
                              child: Consumer(builder: (context, ref, _) {
                                final examEndController =
                                    ref.watch(examEndControllerProvider);
                                return examEndController.maybeWhen(
                                  orElse: () {
                                    return CustomButton(
                                      backgroundColor:
                                          context.colorScheme.primaryContainer,
                                      foregroundColor: Colors.white,
                                      title: ref.watch(
                                                  questionHandlerControllerProvider) ==
                                              (widget.examModel.questionCount! -
                                                  1)
                                          ? S.of(context).submit
                                          : S.of(context).next,
                                      onPressed: () => _action(
                                        isSkip: false,
                                        context: context,
                                        ref: ref,
                                        questionID: question.id,
                                        isSubmit: ref.watch(
                                                    questionHandlerControllerProvider) ==
                                                (widget.examModel
                                                        .questionCount! -
                                                    1)
                                            ? true
                                            : false,
                                        isMultiChoice: question.questionType ==
                                            'multiple_choice',
                                      ),
                                    );
                                  },
                                  loading: () => SizedBox(
                                    height: 60.h,
                                    child: const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        );
      },
      orElse: () => Container(),
    );
  }

  void _action({
    required bool isSkip,
    required WidgetRef ref,
    required int questionID,
    required BuildContext context,
    required bool isSubmit,
    required bool isMultiChoice,
  }) {
    if (ref.read(questionHandlerControllerProvider) + 1 ==
        (widget.examModel.questionCount ?? 0)) {
      if (isSubmit) {
        if (isMultiChoice) {
          if (ref.watch(selectedOptionsProvider).isEmpty) {
            return;
          }
          ref.read(selectedAnswerControllerProvider.notifier).addAnswer({
            'question_id': questionID,
            'choices': ref.watch(selectedOptionsProvider)
          });
        } else {
          if (ref.watch(selectedOptionProvider) == null) {
            return;
          }

          ref.read(selectedAnswerControllerProvider.notifier).addAnswer({
            'question_id': questionID,
            'choice': ref.watch(selectedOptionProvider)
          });
        }
      } else {
        if (isMultiChoice) {
          ref.read(selectedAnswerControllerProvider.notifier).addAnswer({
            'question_id': questionID,
            'choices': ref.watch(selectedOptionsProvider)
          });
        } else {
          ref.read(selectedAnswerControllerProvider.notifier).addAnswer({
            'question_id': questionID,
            'choice': ref.watch(selectedOptionProvider)
          });
        }
      }

      ref
          .read(examEndControllerProvider.notifier)
          .endExam(
            examId: widget.examModel.id!,
            answer: ref.read(selectedAnswerControllerProvider),
          )
          .then((isSuccess) {
        if (isSuccess) {
          if (context.mounted) {
            GoRouter.of(context).go(Routes.examResultScreen, extra: false);
          }
        }
      });
      return;
    }
    if (isSubmit) {
      if (isMultiChoice) {
        if (ref.watch(selectedOptionsProvider).isEmpty) {
          return;
        }
        ref.read(selectedAnswerControllerProvider.notifier).addAnswer({
          'question_id': questionID,
          'choices': ref.watch(selectedOptionsProvider)
        });
      } else {
        if (ref.read(selectedOptionProvider) == null) {
          return;
        }
        ref.read(questionHandlerControllerProvider.notifier).nextQuestion(
            answer: {
              'question_id': questionID,
              'choice': ref.watch(selectedOptionProvider)
            });
      }
    } else {
      if (isMultiChoice) {
        if (!isSkip) {
          if (ref.read(selectedOptionsProvider).isEmpty) {
            // CLEAR
            GlobalFunction.showCustomSnackbar(
              message: 'Please select an option',
              isSuccess: false,
            );
            return;
          }
        } else {
          ref.read(selectedOptionsProvider.notifier).state = [];
        }

        ref.read(questionHandlerControllerProvider.notifier).nextQuestion(
            answer: {
              'question_id': questionID,
              'choices': ref.watch(selectedOptionsProvider)
            });
      } else {
        if (!isSkip) {
          if (ref.read(selectedOptionProvider) == null) {
            // snackbar
            GlobalFunction.showCustomSnackbar(
              message: 'Please select an option',
              isSuccess: false,
            );
            return;
          }
        } else {
          ref.read(selectedOptionProvider.notifier).state = null;
        }
        ref.read(questionHandlerControllerProvider.notifier).nextQuestion(
            answer: {
              'question_id': questionID,
              'choice': ref.watch(selectedOptionProvider)
            });
      }
    }
  }
}
