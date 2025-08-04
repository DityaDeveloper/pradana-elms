import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lms/core/constants/app_constants.dart';
import 'package:lms/features/exam/data/exam_repository.dart';
import 'package:lms/features/exam/models/exam_result_model.dart';
import 'package:lms/features/exam/models/question_model.dart';
import 'package:lms/utils/api_client.dart';

class ExamRepositoryImp implements ExamRepository {
  final Ref ref;
  ExamRepositoryImp(this.ref);
  @override
  Future<List<QuestionModel>> startExam({required int examId}) async {
    try {
      final response = await ref.read(apiClientProvider).get(
        AppConstants.startExam,
        query: {'exam_id': examId},
      );
      final List<dynamic> questions = response.data['data']['questions'];

      final List<QuestionModel> questionList = questions
          .map<QuestionModel>((question) => QuestionModel.fromMap(question))
          .toList();

      return questionList;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ExamResultModel> endExam(
      {required int examId, required List<Object> answer}) async {
    try {
      final response = await ref.read(apiClientProvider).post(
        AppConstants.submitExam,
        data: {'answers': answer},
        queryParameters: {'exam_id': examId},
      );
      return ExamResultModel.fromMap(response.data['data']['results']);
    } catch (e) {
      rethrow;
    }
  }
}
