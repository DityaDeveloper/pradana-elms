import 'dart:convert';

class User {
  int? id;
  String? name;
  String? phone;
  String? email;
  int? parentId;
  dynamic countryId;
  dynamic address;
  dynamic postalCode;
  dynamic stateId;
  dynamic cityId;
  dynamic gender;
  dynamic dateOfBirth;
  String? profilePicture;
  String? userType;
  int? isActive;
  int? otpVerified;
  dynamic academicInfo;
  dynamic subscription;

  User({
    this.id,
    this.name,
    this.phone,
    this.email,
    this.parentId,
    this.countryId,
    this.address,
    this.postalCode,
    this.stateId,
    this.cityId,
    this.gender,
    this.dateOfBirth,
    this.profilePicture,
    this.userType,
    this.isActive,
    this.otpVerified,
    this.academicInfo,
    this.subscription,
  });

  factory User.fromMap(Map<String, dynamic> data) => User(
        id: data['id'] as int?,
        name: data['name'] as String?,
        phone: data['phone'] as String?,
        email: data['email'] as String?,
        parentId: data['parent_id'] as int?,
        countryId: data['country_id'] as dynamic,
        address: data['address'] as dynamic,
        postalCode: data['postal_code'] as dynamic,
        stateId: data['state_id'] as dynamic,
        cityId: data['city_id'] as dynamic,
        gender: data['gender'] as dynamic,
        dateOfBirth: data['date_of_birth'] as dynamic,
        profilePicture: data['profile_picture'] as String?,
        userType: data['user_type'] as String?,
        isActive: data['is_active'] as int?,
        otpVerified: data['otp_verified'] as int?,
        academicInfo: data['academic_info'] as dynamic,
        subscription: data['subscription'] as dynamic,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'phone': phone,
        'email': email,
        'parent_id': parentId,
        'country_id': countryId,
        'address': address,
        'postal_code': postalCode,
        'state_id': stateId,
        'city_id': cityId,
        'gender': gender,
        'date_of_birth': dateOfBirth,
        'profile_picture': profilePicture,
        'user_type': userType,
        'is_active': isActive,
        'otp_verified': otpVerified,
        'academic_info': academicInfo,
        'subscription': subscription,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [User].
  factory User.fromJson(String data) {
    return User.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [User] to a JSON string.
  String toJson() => json.encode(toMap());
}
