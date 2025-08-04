import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lms/features/profile/models/address_model.dart';

final selectedCategoryIdProvider = StateProvider<int?>((ref) {
  return null;
});

final selectedAddressModelProvider = StateProvider<AddressModel?>((ref) {
  return null;
});
