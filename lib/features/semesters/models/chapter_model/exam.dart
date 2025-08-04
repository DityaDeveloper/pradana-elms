import 'dart:convert';

class Exam {
  int? id;
  String? title;
  int? duration;
  int? markPerQuestion;
  // int? passMarks;
  int? questionCount;
  bool? isCompleted;
  bool? isLocked;
  String? media;

  Exam({
    this.id,
    this.title,
    this.duration,
    this.markPerQuestion,
    // this.passMarks,
    this.questionCount,
    this.isCompleted,
    this.isLocked,
    this.media,
  });

  factory Exam.fromMap(Map<String, dynamic> data) => Exam(
        id: data['id'] as int?,
        title: data['title'] as String?,
        duration: data['duration'] as int?,
        markPerQuestion: data['mark_per_question'] as int?,
        // passMarks: data['pass_marks'] as int?,
        questionCount: data['question_count'] as int?,
        isCompleted: data['is_completed'] as bool?,
        isLocked: data['is_locked'] as bool?,
        media: data['media'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'duration': duration,
        'mark_per_question': markPerQuestion,
        // 'pass_marks': passMarks,
        'question_count': questionCount,
        'is_completed': isCompleted,
        'is_locked': isLocked,
        'media': media,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Exam].
  factory Exam.fromJson(String data) {
    return Exam.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Exam] to a JSON string.
  String toJson() => json.encode(toMap());
}
