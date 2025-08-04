import 'dart:convert';

class ProductModel {
  int? id;
  String? name;
  double? price;
  double? discountPrice;
  double? discountAmount;
  double? payableAmount;
  int? stock;
  String? unit;
  int? minOrderQty;
  int? maxOrderQty;
  bool? isFeatured;
  String? image;

  ProductModel({
    this.id,
    this.name,
    this.price,
    this.discountPrice,
    this.stock,
    this.unit,
    this.minOrderQty,
    this.maxOrderQty,
    this.isFeatured,
    this.image,
    this.discountAmount,
    this.payableAmount,
  });

  factory ProductModel.fromMap(Map<String, dynamic> data) => ProductModel(
        id: data['id'] as int?,
        name: data['name'] as String?,
        price: data['price'] as double?,
        discountPrice: data['discount_price'] as double?,
        discountAmount: data['discount_amount'] as double?,
        payableAmount: data['payable_amount'] as double?,
        stock: data['stock'] as int?,
        unit: data['unit'] as String?,
        minOrderQty: data['min_order_qty'] as int?,
        maxOrderQty: data['max_order_qty'] as int?,
        isFeatured: data['is_featured'] as bool?,
        image: data['image'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'price': price,
        'discount_price': discountPrice,
        'stock': stock,
        'unit': unit,
        'min_order_qty': minOrderQty,
        'max_order_qty': maxOrderQty,
        'is_featured': isFeatured,
        'image': image,
        'discount_amount': discountAmount,
        'payable_amount': payableAmount,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [ProductModel].
  factory ProductModel.fromJson(String data) {
    return ProductModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [ProductModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
