import 'dart:convert';

class QuizQuestionModel {
  final int id;
  final String question;
  final String questionType;
  final String? media;
  final List<OptionModel> options;
  QuizQuestionModel({
    required this.id,
    required this.question,
    required this.questionType,
    required this.media,
    required this.options,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'question_text': question,
      'question_type': questionType,
      'media': media,
      'options': options.map((x) => x.toMap()).toList(),
    };
  }

  factory QuizQuestionModel.fromMap(Map<String, dynamic> map) {
    return QuizQuestionModel(
      id: map['id'] as int,
      question: map['question_text'] as String,
      questionType: map['question_type'] as String,
      media: map['media'] as String?,
      options: List<OptionModel>.from(
        (map['options'] as List<dynamic>).map<OptionModel>(
          (x) => OptionModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }
  factory QuizQuestionModel.empty() => QuizQuestionModel(
        id: 0,
        question: '',
        questionType: '',
        media: '',
        options: [],
      );
  String toJson() => json.encode(toMap());

  factory QuizQuestionModel.fromJson(String source) =>
      QuizQuestionModel.fromMap(json.decode(source) as Map<String, dynamic>);
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
