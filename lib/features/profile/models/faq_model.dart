import 'dart:convert';

class FaqModel {
  int? id;
  String? question;
  String? answer;

  FaqModel({this.id, this.question, this.answer});

  factory FaqModel.fromMap(Map<String, dynamic> data) => FaqModel(
        id: data['id'] as int?,
        question: data['question'] as String?,
        answer: data['answer'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'question': question,
        'answer': answer,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [FaqModel].
  factory FaqModel.fromJson(String data) {
    return FaqModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [FaqModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
