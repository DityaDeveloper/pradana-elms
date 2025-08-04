import 'dart:convert';

class Currency {
  int? id;
  String? name;
  String? symbol;
  String? code;
  double? exchangeRate;

  Currency({this.id, this.name, this.symbol, this.code, this.exchangeRate});

  factory Currency.fromMap(Map<String, dynamic> data) => Currency(
        id: data['id'] as int?,
        name: data['name'] as String?,
        symbol: data['symbol'] as String?,
        code: data['code'] as String?,
        exchangeRate: (data['exchange_rate'] as num?)?.toDouble(),
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'symbol': symbol,
        'code': code,
        'exchange_rate': exchangeRate,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Currency].
  factory Currency.fromJson(String data) {
    return Currency.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Currency] to a JSON string.
  String toJson() => json.encode(toMap());
}
