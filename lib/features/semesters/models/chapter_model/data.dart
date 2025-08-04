import 'dart:convert';

import 'chapter.dart';
import 'exam_term.dart';

class Data {
  List<Chapter>? chapters;
  List<ExamTerm>? examTerms;
  int? totalItems;
  int? pageNumber;
  int? itemsPerPage;

  Data({
    this.chapters,
    this.examTerms,
    this.totalItems,
    this.pageNumber,
    this.itemsPerPage,
  });

  factory Data.fromMap(Map<String, dynamic> data) => Data(
        chapters: (data['chapters'] as List<dynamic>?)
            ?.map((e) => Chapter.fromMap(e as Map<String, dynamic>))
            .toList(),
        examTerms: (data['exam_terms'] as List<dynamic>?)
            ?.map((e) => ExamTerm.fromMap(e as Map<String, dynamic>))
            .toList(),
        totalItems: data['total_items'] as int?,
        pageNumber: data['page_number'] as int?,
        itemsPerPage: data['items_per_page'] as int?,
      );

  Map<String, dynamic> toMap() => {
        'chapters': chapters?.map((e) => e.toMap()).toList(),
        'exam_terms': examTerms?.map((e) => e.toMap()).toList(),
        'total_items': totalItems,
        'page_number': pageNumber,
        'items_per_page': itemsPerPage,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Data].
  factory Data.fromJson(String data) {
    return Data.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Data] to a JSON string.
  String toJson() => json.encode(toMap());
}
