import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lms/core/utils/extensions.dart';
import 'package:lms/features/quiz/logic/quiz_providers.dart';
import 'package:lms/features/quiz/models/question_model.dart';

import '../quiz_screen.dart';

class QuizOptionCard extends ConsumerWidget {
  final OptionModel option;
  final int quizId;
  final int questionId;
  final int questionCount;
  final int seenCount;
  const QuizOptionCard({
    super.key,
    required this.option,
    required this.quizId,
    required this.questionId,
    required this.questionCount,
    required this.seenCount,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isSelected = ref.watch(selectedOptionProvider) != null &&
        ref.watch(selectedOptionProvider) == option.text;
    bool isSelectedAndCorrect = isSelected && option.isCorrect == true;

    return AbsorbPointer(
      absorbing: ref.watch(selectedOptionProvider) != null,
      child: Material(
        color: Colors.white,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () {
            ref.read(isLoadingStateProvider.notifier).state = true;
            ref.read(selectedOptionProvider.notifier).state = option.text;
            Future.delayed(const Duration(seconds: 1), () {
              ref.read(quizControllerProvider.notifier).submitQuiz(
                quizId: quizId,
                answer: {
                  'question_id': questionId,
                  'choice': ref.watch(selectedOptionProvider),
                  'skip': false
                },
              );
              ref.refresh(selectedOptionProvider.notifier).state;
            });
          },
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(12.r),
            decoration: _getBoxDecoration(
                isSelected: isSelected, isCorrect: isSelectedAndCorrect),
            child: Text(
              option.text,
              style: context.textTheme.bodyMedium,
            ),
          ),
        ),
      ),
    );
  }

  BoxDecoration _unselectedBoxDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: const Border(
        left: BorderSide(width: 1, color: Color(0xFFE7E7E7)),
        top: BorderSide(width: 1, color: Color(0xFFE7E7E7)),
        right: BorderSide(width: 1, color: Color(0xFFE7E7E7)),
        bottom: BorderSide(width: 2, color: Color(0xFFE7E7E7)),
      ),
    );
  }

  BoxDecoration _currectBoxDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: const Border(
        left: BorderSide(width: 1, color: Color(0xFF36B37E)),
        top: BorderSide(width: 1, color: Color(0xFF36B37E)),
        right: BorderSide(width: 1, color: Color(0xFF36B37E)),
        bottom: BorderSide(width: 2, color: Color(0xFF36B37E)),
      ),
    );
  }

  BoxDecoration _wrongBoxDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: const Border(
        left: BorderSide(width: 1, color: Color(0xFFFF5630)),
        top: BorderSide(width: 1, color: Color(0xFFFF5630)),
        right: BorderSide(width: 1, color: Color(0xFFFF5630)),
        bottom: BorderSide(width: 2, color: Color(0xFFFF5630)),
      ),
    );
  }

  BoxDecoration _getBoxDecoration(
      {required bool isSelected, bool isCorrect = false}) {
    if (isSelected) {
      return isCorrect ? _currectBoxDecoration() : _wrongBoxDecoration();
    }
    return _unselectedBoxDecoration();
  }
}

final selectedOptionProvider = StateProvider<String?>((ref) {
  return null;
});
