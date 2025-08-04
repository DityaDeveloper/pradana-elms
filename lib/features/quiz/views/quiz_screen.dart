import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:lms/core/navigation/app_router.dart';
import 'package:lms/core/utils/extensions.dart';
import 'package:lms/core/widgets/exam_bg.dart';
import 'package:lms/features/exam/logic/exam_question_controller.dart';
import 'package:lms/features/exam/views/widgets/exam_exit_confirmation_dialog.dart';
import 'package:lms/features/quiz/logic/quiz_providers.dart';
import 'package:lms/features/quiz/models/quiz_model.dart';
import 'package:lms/features/quiz/models/quiz_session_model.dart';
import 'package:lms/features/quiz/views/widgets/quiz_option_card.dart';
import 'package:lms/features/quiz/views/widgets/quiz_timer_widget.dart';
import 'package:lms/features/semesters/models/chapter_model/quiz.dart';
import 'package:lms/gen/assets.gen.dart';
import 'package:lms/generated/l10n.dart';

class QuizScreen extends StatelessWidget {
  final Quiz quizModel;

  const QuizScreen({
    super.key,
    required this.quizModel,
  });

  @override
  Widget build(BuildContext context) {
    return ExamBG(
      bottomWidget: _QuizBottomNav(quizModel),
      child: Column(
        children: [
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: _TitleAndScoreBoardWidget(quizModel),
          ),
          Flexible(
            flex: 5,
            fit: FlexFit.loose,
            child: _QuestionCardWidget(quizModel),
          ),
        ],
      ),
    );
  }
}

class _QuizBottomNav extends ConsumerWidget {
  final Quiz quizModel;

  _QuizBottomNav(
    this.quizModel,
  );
  late QuizModel? quizModelData;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    quizModelData = ref.watch(quizControllerProvider).maybeWhen(
        data: (data) {
          print('Call after getting data');
          if (data.question == null) {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              GoRouter.of(context).go(Routes.quizResultScreen, extra: {
                'isFromChapter': false,
                'result': data.quizSession.result
              });
            });
          }
          return data;
        },
        orElse: () => quizModelData);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${quizModelData?.quizSession.seenQuestions.length} ${S.of(context).ofT} ${quizModel.questionCount}',
            style: context.textTheme.bodyMedium
                ?.copyWith(fontWeight: FontWeight.w700),
          ),
          ref.watch(isLoadingStateProvider)
              ? const SizedBox.shrink()
              : TextButton(
                  onPressed: () {
                    if (ref.read(quizControllerProvider).isLoading) {
                      return;
                    }
                    ref.read(quizControllerProvider.notifier).submitQuiz(
                      quizId: quizModel.id,
                      answer: {
                        'question_id': quizModelData?.question?.id,
                        'choice': null,
                        'skip': true
                      },
                    );
                  },
                  child: Text(
                    S.of(context).skip,
                    style: context.textTheme.bodyMedium,
                  ),
                )
        ],
      ),
    );
  }
}

class _TitleAndScoreBoardWidget extends ConsumerWidget {
  final Quiz quizModel;
  const _TitleAndScoreBoardWidget(this.quizModel);

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
                    description: quizModel.title,
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
                quizModel.title,
                maxLines: 2,
                style: context.textTheme.titleSmall,
              ),
            ),
          ],
        ),
        Gap(8.h),
        _ScoreContainerWidget()
      ],
    );
  }
}

class _ScoreContainerWidget extends ConsumerWidget {
  _ScoreContainerWidget();

  late QuizSessionModel quizSessionData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    quizSessionData = ref.watch(quizControllerProvider).maybeWhen(
        data: (data) => data.quizSession, orElse: () => quizSessionData);

    return Container(
      width: 202.w,
      height: 40.h,
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      decoration: ShapeDecoration(
        color: const Color(0xFFF6F6F6),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _scoreRowWidget(
              context: context,
              icon: Assets.svgs.correct,
              score: quizSessionData.rightAnswerCount),
          _scoreRowWidget(
              context: context,
              icon: Assets.svgs.incorrect,
              score: quizSessionData.wrongAnswerCount),
          _scoreRowWidget(
              context: context,
              icon: Assets.svgs.skip,
              score: quizSessionData.skippedAnswerCount),
        ],
      ),
    );
  }

  Widget _scoreRowWidget({
    required BuildContext context,
    required String icon,
    required int score,
  }) {
    return Row(
      children: [
        SvgPicture.asset(
          icon,
        ),
        Gap(8.w),
        Text(
          '$score',
          style: context.textTheme.bodyLarge,
        )
      ],
    );
  }
}

class _QuestionCardWidget extends ConsumerStatefulWidget {
  final Quiz quizModel;
  const _QuestionCardWidget(
    this.quizModel,
  );

  @override
  ConsumerState<_QuestionCardWidget> createState() =>
      _QuestionCardWidgetState();
}

class _QuestionCardWidgetState extends ConsumerState<_QuestionCardWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _animation;
  final GlobalKey<QuizTimerWidgetState> _timerWidgetKey =
      GlobalKey<QuizTimerWidgetState>();
  bool showAnimation = false;
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _animation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _animationController.forward();
  }

  void startAnimationAgain() {
    _animationController.reset();
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  late QuizModel? quizModel;
  @override
  Widget build(BuildContext context) {
    quizModel = ref.watch(quizControllerProvider).maybeWhen(
      data: (data) {
        startAnimationAgain();
        return data;
      },
      orElse: () {
        _timerWidgetKey.currentState?.resetTimer();
        return quizModel;
      },
    );
    return quizModel?.question != null
        ? AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Transform.scale(
                scale: _animation.value,
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    key: ValueKey(quizModel?.question?.id),
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      QuizTimerWidget(
                        key: _timerWidgetKey,
                        duration: widget.quizModel.durationPerQuestion,
                        startTimer: (v) {
                          debugPrint('Start Timer');
                        },
                        pauseTimer: (v) {
                          debugPrint('Pause Timer');
                        },
                        onTimerEnded: (v) {
                          ref.read(quizControllerProvider.notifier).submitQuiz(
                            quizId: widget.quizModel.id,
                            answer: {
                              'question_id': quizModel?.question?.id,
                              'choice': null,
                              'skip': true
                            },
                          );
                          _timerWidgetKey.currentState?.resetTimer();
                        },
                        onTimerChanged: (v) {
                          debugPrint('Timer Changed');
                        },
                      ),
                      Gap(12.h),
                      if (quizModel?.question?.media != null)
                        Container(
                          height: 185.h,
                          margin: EdgeInsets.only(bottom: 11.h),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                            image: DecorationImage(
                              image: CachedNetworkImageProvider(
                                quizModel!.question!.media!,
                              ),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      Text(
                        quizModel!.question!.question,
                        style: context.textTheme.titleSmall
                            ?.copyWith(fontSize: 18.sp),
                      ),
                      Gap(12.h),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: List.generate(
                          quizModel!.question!.options.length,
                          (index) {
                            final option = quizModel?.question!.options[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: QuizOptionCard(
                                quizId: widget.quizModel.id,
                                option: option!,
                                questionId: quizModel!.question!.id,
                                questionCount: widget.quizModel.questionCount,
                                seenCount:
                                    quizModel!.quizSession.seenQuestions.length,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          )
        : const SizedBox.shrink();
  }
}

final isLoadingStateProvider = StateProvider.autoDispose<bool>((ref) => false);
