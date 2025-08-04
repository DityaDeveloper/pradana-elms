class ChildModel {
  int? id;
  String? name;
  String? phone;
  String? profilePicture;
  int? status;

  ChildModel({
    this.id,
    this.name,
    this.phone,
    this.profilePicture,
    this.status,
  });

  factory ChildModel.fromJson(Map<String, dynamic> json) => ChildModel(
        id: json['id'] as int?,
        name: json['name'] as String?,
        phone: json['phone'] as String?,
        profilePicture: json['profile_picture'] as String?,
        status: json['status'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'phone': phone,
        'profile_picture': profilePicture,
        'status': status,
      };
}
