import 'package:hive_flutter/hive_flutter.dart';
import 'package:lms/core/constants/app_constants.dart';
import 'package:lms/features/profile/models/order_model/order_model.dart';
import 'package:lms/features/shop/data/shop_repository_imp.dart';
import 'package:lms/features/shop/logic/cart_controller.dart';
import 'package:lms/features/shop/logic/providers.dart';
import 'package:lms/features/shop/models/category_model.dart';
import 'package:lms/features/shop/models/hive_cart_model.dart';
import 'package:lms/features/shop/models/product_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'shop_controller.g.dart';

@riverpod
class CategoryList extends _$CategoryList {
  @override
  FutureOr<List<CategoryModel>?> build() {
    return ref.read(shopRepositoryImpProvider).getCategory().then((res) {
      if (res.statusCode == 200) {
        List<dynamic> data = res.data['data']['categories'];
        final List<CategoryModel> list =
            data.map((e) => CategoryModel.fromMap(e)).toList();
        if (list.isNotEmpty) {
          ref.read(selectedCategoryIdProvider.notifier).state = list.first.id;
        }
        return list;
      }
      return null;
    });
  }
}

@riverpod
class ProductList extends _$ProductList {
  @override
  FutureOr<List<ProductModel>?> build({required int categoryId}) {
    return ref.read(shopRepositoryImpProvider).getProduct(params: {
      'category_id': categoryId,
    }).then((res) {
      if (res.statusCode == 200) {
        List<dynamic> data = res.data['data']['products'];
        final List<ProductModel> list =
            data.map((e) => ProductModel.fromMap(e)).toList();
        return list;
      }
      return null;
    });
  }
}

@riverpod
class OrderStore extends _$OrderStore {
  @override
  bool build() {
    return false;
  }

  Future<bool> storeOrder(List<HiveCartModel> cartItems) async {
    state = true;
    List<Map<String, dynamic>> items = [];
    Map<String, dynamic> order = {
      'payment_status': 'completed',
    };
    for (var item in cartItems) {
      items.add({
        'product_id': item.id,
        'quantity': item.productsQTY,
      });
    }

    order['items'] = items;
    order['address_id'] = ref.read(selectedAddressModelProvider)?.id ?? 0;

    return ref
        .read(shopRepositoryImpProvider)
        .storeOrder(params: order)
        .then((res) {
      if (res.statusCode == 200) {
        ref.invalidate(selectedAddressModelProvider);
        Hive.box<HiveCartModel>(AppConstants.cartBox).clear();
        ref.read(cartController).clearFiles();
        return true;
      }
      return false;
    }).catchError((e) {
      return false;
    }).whenComplete(() => state = false);
  }
}

@riverpod
class OrderHistoryList extends _$OrderHistoryList {
  // Keep an internal copy of all orders
  List<OrderModel> _originalOrders = [];

  @override
  FutureOr<List<OrderModel>> build() {
    return ref.read(shopRepositoryImpProvider).getOrderHistory().then((res) {
      if (res.statusCode == 200) {
        final data = res.data['data']['orders'] ?? [];
        final list = (data as List).map((e) => OrderModel.fromMap(e)).toList();
        // Save the original
        _originalOrders = list;
        return list;
      }
      return [];
    });
  }

  // Show all orders again by using the original list
  void allOrders() {
    state = AsyncValue.data(_originalOrders);
  }

  void pendingOrders() {
    state = AsyncValue.data(
      _originalOrders.where((o) => o.status == 'pending').toList(),
    );
  }

  void deliveredOrders() {
    state = AsyncValue.data(
      _originalOrders.where((o) => o.status == 'completed').toList(),
    );
  }

  void cancelledOrders() {
    state = AsyncValue.data(
      _originalOrders.where((o) => o.status == 'cancelled').toList(),
    );
  }
}
