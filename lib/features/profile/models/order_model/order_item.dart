import 'dart:convert';

class OrderItem {
  int? id;
  int? productId;
  String? productName;
  String? unit;
  int? quantity;
  double? price;
  double? discount;
  double? subtotal;
  String? media;

  OrderItem({
    this.id,
    this.productId,
    this.productName,
    this.unit,
    this.quantity,
    this.price,
    this.discount,
    this.subtotal,
    this.media,
  });

  factory OrderItem.fromMap(Map<String, dynamic> data) => OrderItem(
        id: data['id'] as int?,
        productId: data['product_id'] as int?,
        productName: data['product_name'] as String?,
        unit: data['unit'] as String?,
        quantity: data['quantity'] as int?,
        price: (data['price'] as num?)?.toDouble(),
        discount: (data['discount'] as num?)?.toDouble(),
        subtotal: data['subtotal'] as double?,
        media: data['media'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'product_id': productId,
        'product_name': productName,
        'unit': unit,
        'quantity': quantity,
        'price': price,
        'discount': discount,
        'subtotal': subtotal,
        'media': media,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [OrderItem].
  factory OrderItem.fromJson(String data) {
    return OrderItem.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [OrderItem] to a JSON string.
  String toJson() => json.encode(toMap());
}
