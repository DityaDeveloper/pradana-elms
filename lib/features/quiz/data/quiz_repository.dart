import 'package:lms/features/quiz/models/quiz_model.dart';

abstract class QuizRepository {
  Future<QuizModel> startQuiz({required int quizId});
  Future<QuizModel> submitQuiz(
      {required int quizId, required Map<String, dynamic> answer});
}
