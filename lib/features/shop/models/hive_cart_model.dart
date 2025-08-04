import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';

class HiveCartModel {
  int id;
  String name;
  String thumbnail;
  double price;
  double discountAmount;
  double payableAmount;
  int productsQTY;

  HiveCartModel({
    required this.id,
    required this.name,
    required this.thumbnail,
    required this.price,
    required this.discountAmount,
    required this.payableAmount,
    required this.productsQTY,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'thumbnail': thumbnail,
      'price': price,
      'discountAmount': discountAmount,
      'payableAmount': payableAmount,
      'productsQTY': productsQTY,
    };
  }

  factory HiveCartModel.fromMap(Map<dynamic, dynamic> map) {
    return HiveCartModel(
      id: map['id'] as int,
      name: map['name'] as String,
      thumbnail: map['thumbnail'] as String,
      price: map['price'] as double,
      discountAmount: map['discountAmount'] as double,
      payableAmount: map['payableAmount'] as double,
      productsQTY: map['productsQTY'] as int,
    );
  }

  HiveCartModel copyWith({
    int? id,
    String? name,
    String? thumbnail,
    double? subTotal,
    int? productsQTY,
  }) {
    return HiveCartModel(
      id: id ?? this.id,
      name: name ?? this.name,
      thumbnail: thumbnail ?? this.thumbnail,
      price: subTotal ?? price,
      discountAmount: discountAmount,
      payableAmount: payableAmount,
      productsQTY: productsQTY ?? this.productsQTY,
    );
  }

  String toJson() => json.encode(toMap());

  factory HiveCartModel.fromJson(String source) =>
      HiveCartModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class HiveCartModelAdapter extends TypeAdapter<HiveCartModel> {
  @override
  final typeId = 0;

  @override
  HiveCartModel read(BinaryReader reader) {
    return HiveCartModel.fromMap(reader.readMap());
  }

  @override
  void write(BinaryWriter writer, HiveCartModel obj) {
    writer.writeMap(obj.toMap());
  }
}
