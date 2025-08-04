import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lms/features/shop/models/hive_cart_model.dart';

final cartController = ChangeNotifierProvider<CartController>((ref) {
  return CartController(ref: ref);
});

class CartController extends ChangeNotifier {
  CartController({required this.ref});
  Ref ref;
  double _totalAmount = 0;
  double _subTotalAmount = 0;
  double _discount = 0;
  double _deliveryCharge = 0;
  double? _cuponDiscount;
  double get deliveryCharge => _deliveryCharge;
  double get discount => _discount;
  double get subTotalAmount => _subTotalAmount;
  double get totalAmount => _totalAmount;
  double get cuponDiscountedAmount => _cuponDiscount ?? 0;

  //getters
  void calculateSubTotal(List<HiveCartModel> cartItems) async {
    _subTotalAmount = 0;
    _discount = 0;
    _totalAmount = 0;

    for (var item in cartItems) {
      _subTotalAmount += item.price * item.productsQTY;
      _totalAmount += item.payableAmount * item.productsQTY;
      _discount += item.discountAmount * item.productsQTY;
    }

    setDeliveryCharge(_deliveryCharge);
    await Future.delayed(Duration.zero);
    notifyListeners();
  }

  void totalDiscountedAmount(double discount) async {
    _discount += discount;
    await Future.delayed(Duration.zero);
    notifyListeners();
  }

  void setDeliveryCharge(double charge) async {
    _deliveryCharge = charge;
    _totalAmount += _deliveryCharge;
    // Notify listeners about the change
    await Future.delayed(Duration.zero);
    notifyListeners();
  }

  void removeDeliveryCharge() async {
    _totalAmount -= _deliveryCharge;
    _deliveryCharge = 0;
    // Notify listeners about the change
    await Future.delayed(Duration.zero);
    notifyListeners();
  }

  void clearFiles() {
    _totalAmount = 0;
    _subTotalAmount = 0;
    _deliveryCharge = 0;
    _discount = 0;
    // _groupDiscount = null;
    // _groupDiscountedAmount = 0;
    notifyListeners();
  }
}
