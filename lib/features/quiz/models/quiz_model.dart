import 'package:lms/features/quiz/models/question_model.dart';
import 'package:lms/features/quiz/models/quiz_session_model.dart';

class QuizModel {
  final QuizSessionModel quizSession;
  final QuizQuestionModel? question;

  QuizModel({
    required this.quizSession,
    required this.question,
  });

  factory QuizModel.fromMap(Map<String, dynamic> map) {
    return QuizModel(
      quizSession: QuizSessionModel.fromMap(map['quiz_session']),
      question: map['question'] != null
          ? QuizQuestionModel.fromMap(map['question'])
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'quiz_session': quizSession.toMap(),
      'question': question?.toMap(),
    };
  }

  factory QuizModel.empty() {
    return QuizModel(
      quizSession: QuizSessionModel.empty(),
      question: QuizQuestionModel.empty(),
    );
  }
}
