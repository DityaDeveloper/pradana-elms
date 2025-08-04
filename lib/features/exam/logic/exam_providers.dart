import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lms/features/exam/data/exam_repository.dart';
import 'package:lms/features/exam/data/exam_repository_imp.dart';
import 'package:lms/features/exam/logic/exam_question_controller.dart';
import 'package:lms/features/exam/models/exam_result_model.dart';
import 'package:lms/features/exam/models/question_model.dart';

// repo providers

final examRepositoryImpProvider = Provider<ExamRepository>((ref) {
  return ExamRepositoryImp(ref);
});

// controller providers
final examStartControllerProvider = StateNotifierProvider<ExamStartController,
    AsyncValue<List<QuestionModel>?>>((ref) {
  return ExamStartController(ref);
});

final examEndControllerProvider =
    StateNotifierProvider<ExamEndController, AsyncValue<ExamResultModel>>(
        (ref) {
  return ExamEndController(ref);
});
