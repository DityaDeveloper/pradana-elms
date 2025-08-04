import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lms/features/progress/models/progress_model/semester.dart';

final selectedProgressSemesterProvider =
    AutoDisposeStateProvider<Semester?>((ref) {
  return null;
});
