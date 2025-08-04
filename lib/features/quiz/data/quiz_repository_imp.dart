import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lms/core/constants/app_constants.dart';
import 'package:lms/features/quiz/data/quiz_repository.dart';
import 'package:lms/utils/api_client.dart';

import '../models/quiz_model.dart';

class QuizRepositoryImp implements QuizRepository {
  final Ref ref;
  QuizRepositoryImp(this.ref);
  @override
  Future<QuizModel> startQuiz({required int quizId}) async {
    try {
      final response = await ref.read(apiClientProvider).get(
        AppConstants.startQuiz,
        query: {'quiz_id': quizId},
      );
      return QuizModel.fromMap(response.data['data']);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<QuizModel> submitQuiz(
      {required int quizId, required Map<String, dynamic> answer}) async {
    try {
      final response = await ref.read(apiClientProvider).post(
        AppConstants.submitQuiz,
        data: {'answer': answer},
        queryParameters: {'quiz_id': quizId},
      );
      return QuizModel.fromMap(response.data['data']);
    } catch (e) {
      rethrow;
    }
  }
}
