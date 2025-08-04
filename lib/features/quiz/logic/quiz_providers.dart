import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lms/features/quiz/data/quiz_repository.dart';
import 'package:lms/features/quiz/data/quiz_repository_imp.dart';
import 'package:lms/features/quiz/logic/quiz_question_controller.dart';
import 'package:lms/features/quiz/models/quiz_model.dart';

// repo providers

final quizRepositoryProvider = Provider<QuizRepository>((ref) {
  return QuizRepositoryImp(ref);
});

// controller providers
final quizControllerProvider = StateNotifierProvider.autoDispose<
    QuizControllerNotifier,
    AsyncValue<QuizModel>>((ref) => QuizControllerNotifier(ref));
