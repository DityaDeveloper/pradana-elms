import 'dart:convert';

class ExamResultModel {
  final String examTitle;
  final int obtainedMarks;
  final int totalMarks;
  final int totalQuestions;
  final int totalAnswers;
  final int totalSkipped;
  final int totalIncorrect;
  ExamResultModel({
    required this.examTitle,
    required this.obtainedMarks,
    required this.totalMarks,
    required this.totalQuestions,
    required this.totalAnswers,
    required this.totalSkipped,
    required this.totalIncorrect,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'exam_title': examTitle,
      'obtained_mark': obtainedMarks,
      'total_mark': totalMarks,
      'total_questions': totalQuestions,
      'total_answered': totalAnswers,
      'total_skipped': totalSkipped,
      'total_incorrect': totalIncorrect,
    };
  }

  factory ExamResultModel.fromMap(Map<String, dynamic> map) {
    return ExamResultModel(
      examTitle: map['exam_title'] as String,
      obtainedMarks: map['obtained_mark'] as int,
      totalMarks: map['total_mark'] as int,
      totalQuestions: map['total_questions'] as int,
      totalAnswers: map['total_answered'] as int,
      totalSkipped: map['total_skipped'] as int,
      totalIncorrect: map['total_incorrect'] as int,
    );
  }
  // Empty constructor
  factory ExamResultModel.empty() => ExamResultModel(
        examTitle: '',
        obtainedMarks: 0,
        totalMarks: 0,
        totalQuestions: 0,
        totalAnswers: 0,
        totalSkipped: 0,
        totalIncorrect: 0,
      );

  String toJson() => json.encode(toMap());

  factory ExamResultModel.fromJson(String source) =>
      ExamResultModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
