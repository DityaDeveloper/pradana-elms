// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:lms/features/semesters/models/chapter_model/quiz.dart';

import 'exam.dart';

class ExamTerm {
  int? id;
  String? title;
  List<Exam>? exams;
  List<Quiz>? quizzes;

  ExamTerm({
    this.id,
    this.title,
    this.exams,
    this.quizzes,
  });

  factory ExamTerm.fromMap(Map<String, dynamic> data) => ExamTerm(
      id: data['id'] as int?,
      title: data['title'] as String?,
      exams: (data['exams'] as List<dynamic>?)
          ?.map((e) => Exam.fromMap(e as Map<String, dynamic>))
          .toList(),
      quizzes: (data['quizzes'] as List<dynamic>?)
          ?.map((e) => Quiz.fromMap(e as Map<String, dynamic>))
          .toList());

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'exams': exams?.map((e) => e.toMap()).toList(),
        'quizzes': quizzes?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [ExamTerm].
  factory ExamTerm.fromJson(String data) {
    return ExamTerm.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [ExamTerm] to a JSON string.
  String toJson() => json.encode(toMap());
}
