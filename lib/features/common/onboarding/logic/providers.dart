import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final onBoardingProvider = StateProvider<PageController>((ref) {
  return PageController(initialPage: 0);
});
