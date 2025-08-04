import 'dart:convert';

class QuizeResultModel {
  final String quizTitle;
  final int obtainedMarks;
  final int totalMarks;
  final int totalQuestions;
  final int totalAnswers;
  final int totalSkipped;
  final int totalIncorrect;
  QuizeResultModel({
    required this.quizTitle,
    required this.obtainedMarks,
    required this.totalMarks,
    required this.totalQuestions,
    required this.totalAnswers,
    required this.totalSkipped,
    required this.totalIncorrect,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'quiz_title': quizTitle,
      'obtained_mark': obtainedMarks,
      'total_mark': totalMarks,
      'total_questions': totalQuestions,
      'total_answered': totalAnswers,
      'total_skipped': totalSkipped,
      'total_incorrect': totalIncorrect,
    };
  }

  factory QuizeResultModel.fromMap(Map<String, dynamic> map) {
    return QuizeResultModel(
      quizTitle: map['quiz_title'] as String,
      obtainedMarks: map['obtained_mark'] as int,
      totalMarks: map['total_mark'] as int,
      totalQuestions: map['total_questions'] as int,
      totalAnswers: map['total_answered'] as int,
      totalSkipped: map['total_skipped'] as int,
      totalIncorrect: map['total_incorrect'] as int,
    );
  }
  // Empty constructor
  factory QuizeResultModel.empty() => QuizeResultModel(
        quizTitle: '',
        obtainedMarks: 0,
        totalMarks: 0,
        totalQuestions: 0,
        totalAnswers: 0,
        totalSkipped: 0,
        totalIncorrect: 0,
      );

  String toJson() => json.encode(toMap());

  factory QuizeResultModel.fromJson(String source) =>
      QuizeResultModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
