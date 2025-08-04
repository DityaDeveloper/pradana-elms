import 'dart:convert';

class CurrencyConfig {
  String? defaultCurrency;
  String? currencySymbolFormat;
  String? decimalSeparator;
  String? noOfDecimals;
  String? currencyPosition;

  CurrencyConfig({
    this.defaultCurrency,
    this.currencySymbolFormat,
    this.decimalSeparator,
    this.noOfDecimals,
    this.currencyPosition,
  });

  factory CurrencyConfig.fromMap(Map<String, dynamic> data) {
    return CurrencyConfig(
      defaultCurrency: data['default_currency'] as String?,
      currencySymbolFormat: data['currency_symbol_format'] as String?,
      decimalSeparator: data['decimal_separator'] as String?,
      noOfDecimals: data['no_of_decimals'] as String?,
      currencyPosition: data['currency_position'] as String?,
    );
  }

  Map<String, dynamic> toMap() => {
        'default_currency': defaultCurrency,
        'currency_symbol_format': currencySymbolFormat,
        'decimal_separator': decimalSeparator,
        'no_of_decimals': noOfDecimals,
        'currency_position': currencyPosition,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [CurrencyConfig].
  factory CurrencyConfig.fromJson(String data) {
    return CurrencyConfig.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [CurrencyConfig] to a JSON string.
  String toJson() => json.encode(toMap());
}
