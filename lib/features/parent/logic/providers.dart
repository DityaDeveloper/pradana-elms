import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lms/features/parent/models/child_model.dart';

final selectedChildProvider = StateProvider<ChildModel?>((ref) => null);
