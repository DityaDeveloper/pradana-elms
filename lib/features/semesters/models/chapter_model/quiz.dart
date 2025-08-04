import 'dart:convert';

class Quiz {
  final int id;
  final String title;
  final int durationPerQuestion;
  final int markPerQuestion;
  final int questionCount;
  final bool isCompleted;
  final bool isLocked;
  final String media;
  Quiz({
    required this.id,
    required this.title,
    required this.durationPerQuestion,
    required this.markPerQuestion,
    required this.questionCount,
    required this.isCompleted,
    this.isLocked = false,
    required this.media,
  });

  Quiz copyWith({
    int? id,
    String? title,
    int? durationPerQuestion,
    int? markPerQuestion,
    int? questionCount,
    bool? isCompleted,
    bool? isLocked,
    String? media,
  }) {
    return Quiz(
      id: id ?? this.id,
      title: title ?? this.title,
      durationPerQuestion: durationPerQuestion ?? this.durationPerQuestion,
      markPerQuestion: markPerQuestion ?? this.markPerQuestion,
      questionCount: questionCount ?? this.questionCount,
      isCompleted: isCompleted ?? this.isCompleted,
      isLocked: isLocked ?? this.isLocked,
      media: media ?? this.media,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'duration_per_question': durationPerQuestion,
      'mark_per_question': markPerQuestion,
      'question_count': questionCount,
      'is_completed': isCompleted,
      'is_locked': isLocked,
      'media': media,
    };
  }

  factory Quiz.fromMap(Map<String, dynamic> map) {
    return Quiz(
      id: map['id'].toInt() as int,
      title: map['title'] as String,
      durationPerQuestion: map['duration_per_question'].toInt() as int,
      markPerQuestion: map['mark_per_question'].toInt() as int,
      questionCount: map['question_count'].toInt() as int,
      isCompleted: map['is_completed'] as bool,
      isLocked: map['is_locked'] as bool,
      media: map['media'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Quiz.fromJson(String source) =>
      Quiz.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Quiz(id: $id, title: $title, duration_per_question: $durationPerQuestion, mark_per_question: $markPerQuestion, question_count: $questionCount)';
  }

  @override
  bool operator ==(covariant Quiz other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.durationPerQuestion == durationPerQuestion &&
        other.markPerQuestion == markPerQuestion &&
        other.questionCount == questionCount;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        durationPerQuestion.hashCode ^
        markPerQuestion.hashCode ^
        questionCount.hashCode;
  }
}
