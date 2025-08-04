import 'dart:convert';

import 'package:lms/features/quiz/models/quiz_result_model.dart';

class QuizSessionModel {
  final int id;
  final List<int> seenQuestions;
  final int rightAnswerCount;
  final int wrongAnswerCount;
  final int skippedAnswerCount;
  final int obtainedMark;
  final QuizeResultModel result;

  QuizSessionModel({
    required this.id,
    required this.seenQuestions,
    required this.rightAnswerCount,
    required this.wrongAnswerCount,
    required this.skippedAnswerCount,
    required this.obtainedMark,
    required this.result,
  });

  QuizSessionModel copyWith({
    int? id,
    List<int>? seenQuestions,
    int? rightAnswerCount,
    int? wrongAnswerCount,
    int? skippedAnswerCount,
    int? obtainedMark,
    QuizeResultModel? result,
  }) {
    return QuizSessionModel(
        id: id ?? this.id,
        seenQuestions: seenQuestions ?? this.seenQuestions,
        rightAnswerCount: rightAnswerCount ?? this.rightAnswerCount,
        wrongAnswerCount: wrongAnswerCount ?? this.wrongAnswerCount,
        skippedAnswerCount: skippedAnswerCount ?? this.skippedAnswerCount,
        obtainedMark: obtainedMark ?? this.obtainedMark,
        result: result ?? this.result);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'seen_questions': seenQuestions,
      'right_answer_count': rightAnswerCount,
      'wrong_answer_count': wrongAnswerCount,
      'skipped_answer_count': skippedAnswerCount,
      'obtained_mark': obtainedMark,
      'result': result.toMap(),
    };
  }

  factory QuizSessionModel.fromMap(Map<String, dynamic> map) {
    return QuizSessionModel(
      id: map['id'] as int,
      seenQuestions: List<int>.from(map['seen_question_ids']),
      rightAnswerCount: map['right_answer_count'] as int,
      wrongAnswerCount: map['wrong_answer_count'] as int,
      skippedAnswerCount: map['skipped_answer_count'] as int,
      obtainedMark: map['obtained_mark'] as int,
      result: QuizeResultModel.fromMap(map['results']),
    );
  }

  factory QuizSessionModel.empty() {
    return QuizSessionModel(
      id: 0,
      seenQuestions: [],
      rightAnswerCount: 0,
      wrongAnswerCount: 0,
      skippedAnswerCount: 0,
      obtainedMark: 0,
      result: QuizeResultModel.empty(),
    );
  }

  String toJson() => json.encode(toMap());

  factory QuizSessionModel.fromJson(String source) =>
      QuizSessionModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'QuizSessionModel(id: $id, rightAnswerCount: $rightAnswerCount, wrongAnswerCount: $wrongAnswerCount, skippedAnswerCount: $skippedAnswerCount, obtainedMark: $obtainedMark)';
  }

  @override
  bool operator ==(covariant QuizSessionModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.rightAnswerCount == rightAnswerCount &&
        other.wrongAnswerCount == wrongAnswerCount &&
        other.skippedAnswerCount == skippedAnswerCount &&
        other.obtainedMark == obtainedMark;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        rightAnswerCount.hashCode ^
        wrongAnswerCount.hashCode ^
        skippedAnswerCount.hashCode ^
        obtainedMark.hashCode;
  }
}
