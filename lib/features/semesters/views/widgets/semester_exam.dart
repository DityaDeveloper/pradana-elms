import 'package:cached_network_image/cached_network_image.dart';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:lms/core/constants/app_colors.dart';
import 'package:lms/core/navigation/app_router.dart';
import 'package:lms/core/utils/extensions.dart';
import 'package:lms/core/utils/global_function.dart';
import 'package:lms/features/exam/logic/exam_providers.dart';
import 'package:lms/features/exam/views/widgets/start_exam_bottom_sheet.dart';
import 'package:lms/features/quiz/logic/quiz_providers.dart';
import 'package:lms/features/quiz/models/quiz_model.dart';
import 'package:lms/features/quiz/views/widgets/start_quiz_bottom_sheet.dart';
import 'package:lms/features/semesters/models/chapter_model/exam.dart';
import 'package:lms/features/semesters/models/chapter_model/quiz.dart';
import 'package:lms/gen/assets.gen.dart';
import 'package:lms/generated/l10n.dart';

class SemesterExam extends ConsumerStatefulWidget {
  const SemesterExam({
    super.key,
    required this.title,
    required this.examList,
    required this.quizList,
  });

  final String title;
  final List<Exam> examList;
  final List<Quiz> quizList;

  @override
  ConsumerState<SemesterExam> createState() => _SemesterExamState();
}

class _SemesterExamState extends ConsumerState<SemesterExam> {
  bool _isExpanded = false;
  late QuizModel? quizModelData;
  bool navigationGuardProvider = false;

  @override
  Widget build(BuildContext context) {
    quizModelData = ref.watch(quizControllerProvider).maybeWhen(
        data: (data) {
          if (data.question == null && !navigationGuardProvider) {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              navigationGuardProvider = true;
              context.push(Routes.quizResultScreen, extra: {
                'isFromChapter': true,
                'result': data.quizSession.result
              });
              // GoRouter.of(context).push(Routes.quizResultScreen, extra: {
              //   'isFromChapter': true,
              //   'result': data.quizSession.result
              // });
            });
          }
          return data;
        },
        orElse: () => quizModelData);
    return Theme(
      data: ThemeData().copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        title: Row(
          children: [
            SvgPicture.asset(
              Assets.svgs.bookSaved,
              colorFilter: ColorFilter.mode(
                _isExpanded ? AppColors.primaryColor : Colors.grey,
                BlendMode.srcIn,
              ),
            ),
            Gap(8.w),
            Expanded(
              child: Text(
                widget.title,
                style: context.textTheme.bodyLarge,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        trailing: Transform.rotate(
          angle: _isExpanded ? 3.14 : 0,
          child: SvgPicture.asset(
            Assets.svgs.arrowDown,
            color: _isExpanded ? AppColors.primaryColor : Colors.grey,
          ),
        ),
        backgroundColor: _isExpanded
            ? Color(context.isDarkMode ? 0xff3D3D3D : 0xffF0F8FF)
            : Colors.white,
        collapsedBackgroundColor: context.cardColor,
        onExpansionChanged: (bool expanded) {
          setState(() {
            _isExpanded = expanded;
          });
        },
        children: [
          widget.examList.isEmpty
              ? Center(
                  child: Text(S.of(context).noExamAvailable),
                )
              : Column(
                  children: List.generate(
                    widget.examList.length,
                    (index) => _CustomListTile(
                      thumbnail: widget.examList[index].media ?? '',
                      color: context.cardColor,
                      context: context,
                      serialNo: index + 1,
                      title: widget.examList[index].title ?? '',
                      isComplete: widget.examList[index].isCompleted ?? false,
                      isLocked: widget.examList[index].isLocked ?? false,
                      onTap: () {
                        if (widget.examList[index].isLocked ?? false) {
                          GlobalFunction.showCustomSnackbar(
                              message: "Exam is Locked", isSuccess: false);
                        } else if (widget.examList[index].isCompleted ??
                            false) {
                          // GlobalFunction.showCustomSnackbar(
                          //     message: "Exam Already Completed",
                          //     isSuccess: true);
                          ref.read(examEndControllerProvider.notifier).endExam(
                            examId: widget.examList[index].id ?? 0,
                            answer: [],
                          );
                          ref
                              .read(selectedExamTitleProvider.notifier)
                              .update((ref) => widget.title);
                          context.push(Routes.examResultScreen, extra: true);
                        } else {
                          showModalBottomSheet(
                            isScrollControlled: true,
                            context: context,
                            builder: (_) {
                              WidgetsBinding.instance
                                  .addPostFrameCallback((timeStamp) {
                                ref
                                    .read(selectedExamTitleProvider.notifier)
                                    .update((ref) => widget.title);
                              });
                              return StartExamBottomSheet(
                                exam: widget.examList[index],
                              );
                            },
                          );
                        }
                      },
                    ),
                  ),
                ),
          widget.quizList.isEmpty
              ? Center(
                  child: Text(S.of(context).noQuizAvailable),
                )
              : Column(
                  children: List.generate(
                    widget.quizList.length,
                    (index) => _CustomListTile(
                      thumbnail: widget.quizList[index].media ?? '',
                      color: context.cardColor,
                      context: context,
                      serialNo: index + 1,
                      title: widget.quizList[index].title,
                      isComplete: widget.quizList[index].isCompleted,
                      isLocked: widget.quizList[index].isLocked,
                      onTap: () {
                        if (widget.quizList[index].isLocked) {
                          GlobalFunction.showCustomSnackbar(
                              message: "Quiz is Locked", isSuccess: false);
                        } else if (widget.quizList[index].isCompleted) {
                          navigationGuardProvider = false;
                          // GlobalFunction.showCustomSnackbar(
                          //     message: "Quize Already Completed",
                          //     isSuccess: true);
                          ref
                              .read(selectedExamTitleProvider.notifier)
                              .update((ref) => widget.title);
                          ref.read(quizControllerProvider.notifier).submitQuiz(
                            quizId: widget.quizList[index].id,
                            answer: {},
                          );
                        } else {
                          showModalBottomSheet(
                            isScrollControlled: true,
                            context: context,
                            builder: (_) {
                              WidgetsBinding.instance
                                  .addPostFrameCallback((timeStamp) {
                                ref
                                    .read(selectedExamTitleProvider.notifier)
                                    .update((ref) => widget.title);
                              });
                              return StartQuizBottomSheet(
                                quiz: widget.quizList[index],
                              );
                            },
                          );
                        }
                      },
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}

final selectedExamTitleProvider = StateProvider<String?>((ref) {
  return null;
});

class _CustomListTile extends StatelessWidget {
  final String thumbnail;
  final Color color;
  final int serialNo;
  final String title;
  final bool isComplete;
  final VoidCallback onTap;
  final bool isLocked;
  final BuildContext context;
  const _CustomListTile({
    required this.thumbnail,
    required this.serialNo,
    required this.title,
    required this.onTap,
    this.isComplete = false,
    this.isLocked = false,
    required this.color,
    required this.context,
  });

  @override
  Widget build(BuildContext contextM) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12).r,
        margin: const EdgeInsets.only(bottom: 8, right: 16, left: 16).r,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10).r,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Text(
              serialNo.toString(),
              style: context.textTheme.bodyLarge!.copyWith(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            Gap(8.w),
            Container(
              height: 36.r,
              width: 36.r,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.5),
                borderRadius: BorderRadius.circular(6).r,
              ),
              child: CachedNetworkImage(imageUrl: thumbnail, fit: BoxFit.cover),
            ),
            Gap(8.w),
            Expanded(
              child: Text(
                title,
                overflow: TextOverflow.ellipsis,
                style: context.textTheme.bodyLarge!.copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Gap(4.w),
            SizedBox(
              height: 18.r,
              width: 18.r,
              child: isComplete
                  ? SvgPicture.asset(
                      Assets.svgs.tickCircle,
                      colorFilter:
                          const ColorFilter.mode(Colors.green, BlendMode.srcIn),
                    )
                  : isLocked
                      ? SvgPicture.asset(Assets.svgs.lock)
                      : Transform(
                          alignment: Alignment.center,
                          transform:
                              Localizations.localeOf(context).languageCode ==
                                      'ar'
                                  ? Matrix4.rotationY(math.pi)
                                  : Matrix4.identity(),
                          child: SvgPicture.asset(
                            Assets.svgs.arrowRightCircle,
                          ),
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
