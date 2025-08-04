import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lms/features/exam/logic/exam_providers.dart';
import 'package:lms/features/exam/models/exam_result_model.dart';
import 'package:lms/features/exam/models/question_model.dart';
import 'package:lms/features/exam/views/widgets/exam_option_card.dart';

final questionHandlerControllerProvider =
    StateNotifierProvider<QuestionHandlerController, int>((ref) {
  return QuestionHandlerController(ref);
});

class QuestionHandlerController extends StateNotifier<int> {
  final Ref ref;
  QuestionHandlerController(this.ref) : super(0);

  void nextQuestion({required Map<String, dynamic> answer}) {
    state++;
    ref.read(selectedAnswerControllerProvider.notifier).addAnswer(answer);
    ref.read(selectedOptionProvider.notifier).state = null;
  }

  void previousQuestion() {
    state--;
  }
}

final selectedAnswerControllerProvider =
    StateNotifierProvider<SelectedAnswerController, List<Map<String, dynamic>>>(
        (ref) => SelectedAnswerController(ref));

class SelectedAnswerController
    extends StateNotifier<List<Map<String, dynamic>>> {
  final Ref ref;
  SelectedAnswerController(this.ref) : super([]);

  void addAnswer(Map<String, dynamic> answer) {
    final exsits =
        state.any((element) => element['question_id'] == answer['question_id']);
    if (!exsits) {
      state = [...state, answer];
    }
    ref.refresh(selectedOptionProvider.notifier).state = null;
    ref.refresh(selectedOptionsProvider.notifier).state = [];
  }
}

class ExamStartController
    extends StateNotifier<AsyncValue<List<QuestionModel>?>> {
  final Ref ref;
  ExamStartController(this.ref) : super(const AsyncData(null));

  Future<bool> startExam({required int examId}) async {
    state = const AsyncLoading();
    try {
      final questions = await ref.read(examRepositoryImpProvider).startExam(
            examId: examId,
          );
      state = AsyncData(questions);
      return true;
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
      return false;
    }
  }
}

class ExamEndController extends StateNotifier<AsyncValue<ExamResultModel>> {
  final Ref ref;
  ExamEndController(this.ref) : super(AsyncData(ExamResultModel.empty()));

  Future<bool> endExam(
      {required int examId, required List<Object> answer}) async {
    state = const AsyncLoading();
    try {
      final response = await ref.read(examRepositoryImpProvider).endExam(
            examId: examId,
            answer: answer,
          );
      state = AsyncData(response);
      return true;
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
      return false;
    }
  }
}
