import 'package:lms/features/home/data/home_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'system_setting_controller.g.dart';

@Riverpod(keepAlive: true)
class SystemSetting extends _$SystemSetting {
  late String symbol;
  late String currencyPosition;
  late String supportNumber;

  String get currencySymbol => symbol;

  @override
  void build() {
    init();
    return;
  }

  void init() async {
    final response = await ref.read(homeRepositoryProvider).getSystemSetting();
    symbol = response.data['data']['currency_config']['currency_symbol'];
    currencyPosition =
        response.data['data']['currency_config']['currency_position'];
    supportNumber = response.data['data']['contact_mobile'];
  }

  String currencyValue(double value) {
    if (currencyPosition == 'left') {
      return "$symbol${value.toStringAsFixed(2)}";
    } else {
      return "${value.toStringAsFixed(2)}$symbol";
    }
  }
}
