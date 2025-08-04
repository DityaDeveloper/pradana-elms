import 'package:lms/features/exam/models/exam_result_model.dart';
import 'package:lms/features/exam/models/question_model.dart';

abstract class ExamRepository {
  Future<List<QuestionModel>> startExam({required int examId});
  Future<ExamResultModel> endExam(
      {required int examId, required List<Object> answer});
}
