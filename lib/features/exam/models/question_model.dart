import 'dart:convert';

class QuestionModel {
  final int id;
  final String question;
  final String questionType;
  final String? media;
  final List<OptionModel> options;
  QuestionModel({
    required this.id,
    required this.media,
    required this.question,
    required this.questionType,
    required this.options,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'question_text': question,
      'media': media,
      'question_type': questionType,
      'options': options.map((x) => x.toMap()).toList(),
    };
  }

  factory QuestionModel.fromMap(Map<String, dynamic> map) {
    return QuestionModel(
      id: map['id'] as int,
      question: map['question_text'] as String,
      media: map['media'] as String?,
      questionType: map['question_type'] as String,
      options: List<OptionModel>.from(
        (map['options'] as List<dynamic>).map<OptionModel>(
          (x) => OptionModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory QuestionModel.fromJson(String source) =>
      QuestionModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class OptionModel {
  final String text;
  final bool isCorrect;
  OptionModel({
    required this.text,
    required this.isCorrect,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'text': text,
      'is_correct': isCorrect,
    };
  }

  factory OptionModel.fromMap(Map<String, dynamic> map) {
    return OptionModel(
      text: map['text'] as String,
      isCorrect: map['is_correct'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory OptionModel.fromJson(String source) =>
      OptionModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
