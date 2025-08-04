import 'dart:convert';

class AddressModel {
  int? id;
  String? type;
  String? name;
  String? phone;
  bool? isDefault;
  int? cityId;
  String? cityName;
  int? stateId;
  String? stateName;
  int? countryId;
  String? countryName;
  String? block;
  String? street;
  String? avenue;
  String? house;
  String? addressLine1;
  String? addressLine2;
  int? status;
  double? deliveryCharge;

  AddressModel({
    this.id,
    this.type,
    this.name,
    this.phone,
    this.isDefault,
    this.cityId,
    this.cityName,
    this.stateId,
    this.stateName,
    this.countryId,
    this.countryName,
    this.block,
    this.street,
    this.avenue,
    this.house,
    this.addressLine1,
    this.addressLine2,
    this.status,
    this.deliveryCharge,
  });

  factory AddressModel.fromMap(Map<String, dynamic> data) => AddressModel(
        id: data['id'] as int?,
        type: data['type'] as String?,
        name: data['name'] as String?,
        phone: data['phone'] as String?,
        isDefault: data['is_default'] as bool?,
        cityId: data['city_id'] as int?,
        cityName: data['city_name'] as String?,
        stateId: data['state_id'] as int?,
        stateName: data['state_name'] as String?,
        countryId: data['country_id'] as int?,
        countryName: data['country_name'] as String?,
        block: data['block'] as String?,
        street: data['street'] as String?,
        avenue: data['avenue'] as String?,
        house: data['house'] as String?,
        addressLine1: data['address_line1'] as String?,
        addressLine2: data['address_line2'] as String?,
        status: data['status'] as int?,
        deliveryCharge: data['delivery_charge'] as double?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'type': type,
        'name': name,
        'phone': phone,
        'is_default': isDefault,
        'city_id': cityId,
        'city_name': cityName,
        'state_id': stateId,
        'state_name': stateName,
        'country_id': countryId,
        'country_name': countryName,
        'block': block,
        'street': street,
        'avenue': avenue,
        'house': house,
        'address_line1': addressLine1,
        'status': status,
        'delivery_charge': deliveryCharge,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [AddressModel].
  factory AddressModel.fromJson(String data) {
    return AddressModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [AddressModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
