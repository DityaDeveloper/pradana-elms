import 'dart:convert';

class QuestionDetailsModel {
  final String subject;
  final String semester;
  final String lesson;
  final String time;
  final String chapter;
  QuestionDetailsModel({
    required this.subject,
    required this.semester,
    required this.lesson,
    required this.time,
    required this.chapter,
  });

  QuestionDetailsModel copyWith({
    String? subject,
    String? semester,
    String? lesson,
    String? time,
    String? chapter,
  }) {
    return QuestionDetailsModel(
      subject: subject ?? this.subject,
      semester: semester ?? this.semester,
      lesson: lesson ?? this.lesson,
      time: time ?? this.time,
      chapter: chapter ?? this.chapter,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'subject': subject,
      'semester': semester,
      'lesson': lesson,
      'time': time,
      'chapter': chapter
    };
  }

  factory QuestionDetailsModel.fromMap(Map<String, dynamic> map) {
    return QuestionDetailsModel(
      subject: map['subject'] as String,
      semester: map['semester'] as String,
      lesson: map['lesson'] as String,
      time: map['time'] as String,
      chapter: map['chapter'] as String,
    );
  }

  // empty constructor
  QuestionDetailsModel.empty()
      : this(subject: '', semester: '', lesson: '', time: '', chapter: '');

  String toJson() => json.encode(toMap());

  factory QuestionDetailsModel.fromJson(String source) =>
      QuestionDetailsModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
