import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedSemesterIDProvider =
    AutoDisposeStateProvider<int?>((ref) => null);

final selectedSemesterTitleProvider = StateProvider<String?>((ref) => null);

final isLockedLastSemesterProvider =
    AutoDisposeStateProvider<bool>((ref) => true);

final isReviewedProvider = AutoDisposeStateProvider<bool>((ref) {
  ref.keepAlive();
  return false;
});

final isVideoPlayingProvider = AutoDisposeStateProvider<bool>((ref) {
  return false;
});
