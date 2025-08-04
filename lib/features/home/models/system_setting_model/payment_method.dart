import 'dart:convert';

class PaymentMethod {
  String? name;
  String? gateway;
  int? status;
  String? logo;

  PaymentMethod({this.name, this.gateway, this.status, this.logo});

  factory PaymentMethod.fromMap(Map<String, dynamic> data) => PaymentMethod(
        name: data['name'] as String?,
        gateway: data['gateway'] as String?,
        status: data['status'] as int?,
        logo: data['logo'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'name': name,
        'gateway': gateway,
        'status': status,
        'logo': logo,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [PaymentMethod].
  factory PaymentMethod.fromJson(String data) {
    return PaymentMethod.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [PaymentMethod] to a JSON string.
  String toJson() => json.encode(toMap());
}
