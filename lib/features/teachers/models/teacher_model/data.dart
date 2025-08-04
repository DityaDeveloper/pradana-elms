import 'dart:convert';
import 'package:lms/features/home/models/home_model/instructor.dart';

class Data {
  List<Instructor>? instructors;
  int? totalItems;
  int? currentPage;
  int? itemsPerPage;

  Data({
    this.instructors,
    this.totalItems,
    this.currentPage,
    this.itemsPerPage,
  });

  factory Data.fromMap(Map<String, dynamic> data) => Data(
        instructors: (data['instructors'] as List<dynamic>?)
            ?.map((e) => Instructor.fromMap(e as Map<String, dynamic>))
            .toList(),
        totalItems: data['total_items'] as int?,
        currentPage: data['current_page'] as int?,
        itemsPerPage: data['items_per_page'] as int?,
      );

  Map<String, dynamic> toMap() => {
        'instructors': instructors?.map((e) => e.toMap()).toList(),
        'total_items': totalItems,
        'current_page': currentPage,
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
