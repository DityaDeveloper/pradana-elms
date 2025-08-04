import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lms/features/quiz/logic/quiz_providers.dart';
import 'package:lms/features/quiz/models/quiz_model.dart';

import '../views/quiz_screen.dart';

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
  }

  void previousQuestion() {
    state--;
  }
}

final selectedAnswerControllerProvider =
    StateNotifierProvider<SelectedAnswerController, List<Map<String, dynamic>>>(
        (ref) => SelectedAnswerController());

class SelectedAnswerController
    extends StateNotifier<List<Map<String, dynamic>>> {
  SelectedAnswerController() : super([]);

  void addAnswer(Map<String, dynamic> answer) {
    final exsits =
        state.any((element) => element['question_id'] == answer['question_id']);
    if (!exsits) {
      state = [...state, answer];
    }
  }
}

class QuizControllerNotifier extends StateNotifier<AsyncValue<QuizModel>> {
  final Ref ref;
  QuizControllerNotifier(this.ref) : super(AsyncData(QuizModel.empty()));

  Future<bool> startQuiz({required int quizId}) async {
    state = const AsyncLoading();
    try {
      final questions = await ref.read(quizRepositoryProvider).startQuiz(
            quizId: quizId,
          );
      state = AsyncData(questions);
      return true;
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
      return false;
    }
  }

  Future<bool> submitQuiz(
      {required int quizId, required Map<String, dynamic> answer}) async {
    state = const AsyncLoading();
    try {
      final response = await ref.read(quizRepositoryProvider).submitQuiz(
            quizId: quizId,
            answer: answer,
          );
      ref.read(isLoadingStateProvider.notifier).state = false;
      state = AsyncData(response);
      return true;
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
      return false;
    }
  }
}
