import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

final isPersonalInfoFormViewProvider =
    AutoDisposeStateProvider<bool>((ref) => true);

final imagePickerProvider = AutoDisposeStateProvider<XFile?>((ref) => null);

enum AddressTagEnum { home, office, other }

final addressTagProvider =
    AutoDisposeStateProvider<AddressTagEnum>((ref) => AddressTagEnum.home);

final selectedOrderHistoryProvider =
    AutoDisposeStateProvider<String>((ref) => 'All');
