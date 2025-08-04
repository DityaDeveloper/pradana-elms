// To parse this JSON data, do
//
//     final planModel = planModelFromJson(jsonString);

import 'dart:convert';

PlanModel planModelFromJson(String str) => PlanModel.fromJson(json.decode(str));

String planModelToJson(PlanModel data) => json.encode(data.toJson());

class PlanModel {
  final String? message;
  final Data? data;

  PlanModel({
    this.message,
    this.data,
  });

  factory PlanModel.fromJson(Map<String, dynamic> json) => PlanModel(
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  final int? totalItems;
  final int? currentPage;
  final int? itemsPerPage;
  final List<Plan>? plans;

  Data({
    this.totalItems,
    this.currentPage,
    this.itemsPerPage,
    this.plans,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        totalItems: json["total_items"],
        currentPage: json["current_page"],
        itemsPerPage: json["items_per_page"],
        plans: json["plans"] == null
            ? []
            : List<Plan>.from(json["plans"]!.map((x) => Plan.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total_items": totalItems,
        "current_page": currentPage,
        "items_per_page": itemsPerPage,
        "plans": plans == null
            ? []
            : List<dynamic>.from(plans!.map((x) => x.toJson())),
      };
}

class Plan {
  final int? id;
  final String? name;
  final String? regularPrice;
  final String? price;
  final List<String>? features;
  final int? isPopular;

  Plan({
    this.id,
    this.name,
    this.regularPrice,
    this.price,
    this.features,
    this.isPopular,
  });

  factory Plan.fromJson(Map<String, dynamic> json) => Plan(
        id: json["id"],
        name: json["name"],
        regularPrice: json["regular_price"],
        price: json["price"],
        features: json["features"] == null
            ? []
            : List<String>.from(json["features"]!.map((x) => x)),
        isPopular: json["is_popular"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "regular_price": regularPrice,
        "price": price,
        "features":
            features == null ? [] : List<dynamic>.from(features!.map((x) => x)),
        "is_popular": isPopular,
      };
}
