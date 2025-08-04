import 'dart:convert';

class Pagination {
  int? totalItems;
  int? itemsPerPage;
  int? lastPage;
  int? from;
  int? to;
  int? currentPage;
  dynamic prevPageUrl;
  dynamic nextPageUrl;

  Pagination({
    this.totalItems,
    this.itemsPerPage,
    this.lastPage,
    this.from,
    this.to,
    this.currentPage,
    this.prevPageUrl,
    this.nextPageUrl,
  });

  factory Pagination.fromMap(Map<String, dynamic> data) => Pagination(
        totalItems: data['total_items'] as int?,
        itemsPerPage: data['items_per_page'] as int?,
        lastPage: data['last_page'] as int?,
        from: data['from'] as int?,
        to: data['to'] as int?,
        currentPage: data['current_page'] as int?,
        prevPageUrl: data['prev_page_url'] as dynamic,
        nextPageUrl: data['next_page_url'] as dynamic,
      );

  Map<String, dynamic> toMap() => {
        'total_items': totalItems,
        'items_per_page': itemsPerPage,
        'last_page': lastPage,
        'from': from,
        'to': to,
        'current_page': currentPage,
        'prev_page_url': prevPageUrl,
        'next_page_url': nextPageUrl,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Pagination].
  factory Pagination.fromJson(String data) {
    return Pagination.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Pagination] to a JSON string.
  String toJson() => json.encode(toMap());
}
