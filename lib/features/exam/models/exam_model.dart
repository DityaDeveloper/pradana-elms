class ExamModel {
  ExamModel({
    required this.id,
    required this.title,
    required this.duration,
    required this.markPerQuestion,
    required this.passMarks,
    required this.questionCount,
  });
  late final int id;
  late final String title;
  late final int duration;
  late final int markPerQuestion;
  late final int passMarks;
  late final int questionCount;

  ExamModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    duration = json['duration'];
    markPerQuestion = json['mark_per_question'];
    passMarks = json['pass_marks'];
    questionCount = json['question_count'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'duration': duration,
      'mark_per_question': markPerQuestion,
      'pass_marks': passMarks,
      'question_count': questionCount,
    };
  }
}
