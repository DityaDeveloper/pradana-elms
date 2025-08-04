class NumberUtils {
  static final NumberUtils _instance = NumberUtils._internal();
  factory NumberUtils() {
    return _instance;
  }
  NumberUtils._internal();

  static String formatCurrency(double value) {
    return '\$${value.toStringAsFixed(2)}';
  }
}
