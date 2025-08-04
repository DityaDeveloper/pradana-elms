import 'dart:convert';

import 'order_item.dart';

class OrderModel {
  int? id;
  String? code;
  double? discount;
  double? deliveryCharge;
  double? total;
  double? grandTotal;
  String? name;
  String? phone;
  String? fullAddress;
  String? paymentStatus;
  String? status;
  dynamic deliveredAt;
  String? createdAt;
  List<OrderItem>? orderItems;
  int? totalItems;

  OrderModel({
    this.id,
    this.code,
    this.discount,
    this.deliveryCharge,
    this.total,
    this.grandTotal,
    this.name,
    this.phone,
    this.fullAddress,
    this.paymentStatus,
    this.status,
    this.deliveredAt,
    this.createdAt,
    this.orderItems,
    this.totalItems,
  });

  factory OrderModel.fromMap(Map<String, dynamic> data) => OrderModel(
        id: data['id'] as int?,
        code: data['code'] as String?,
        discount: (data['discount'] as num?)?.toDouble(),
        deliveryCharge: data['delivery_charge'] as double?,
        total: data['total'] as double?,
        grandTotal: data['grand_total'] as double?,
        name: data['name'] as String?,
        phone: data['phone'] as String?,
        fullAddress: data['full_address'] as String?,
        paymentStatus: data['payment_status'] as String?,
        status: data['status'] as String?,
        deliveredAt: data['delivered_at'] as dynamic,
        createdAt: data['created_at'] as String?,
        orderItems: (data['order_items'] as List<dynamic>?)
            ?.map((e) => OrderItem.fromMap(e as Map<String, dynamic>))
            .toList(),
        totalItems: data['total_items'] as int?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'code': code,
        'discount': discount,
        'delivery_charge': deliveryCharge,
        'total': total,
        'grand_total': grandTotal,
        'name': name,
        'phone': phone,
        'full_address': fullAddress,
        'payment_status': paymentStatus,
        'status': status,
        'delivered_at': deliveredAt,
        'created_at': createdAt,
        'order_items': orderItems?.map((e) => e.toMap()).toList(),
        'total_items': totalItems,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [OrderModel].
  factory OrderModel.fromJson(String data) {
    return OrderModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [OrderModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
