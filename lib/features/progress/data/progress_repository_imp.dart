import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lms/core/constants/app_constants.dart';
import 'package:lms/features/progress/data/progress_repository.dart';
import 'package:lms/utils/api_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'progress_repository_imp.g.dart';

@riverpod
ProgressRepositoryImp progressRepositoryImp(ProgressRepositoryImpRef ref) {
  return ProgressRepositoryImp(ref);
}

class ProgressRepositoryImp implements ProgressRepository {
  final Ref ref;
  ProgressRepositoryImp(this.ref);

  @override
  Future<Response> getProgressInfo({required int studentId, int? semesterId}) {
    return ref
        .read(apiClientProvider)
        .get(AppConstants.studentProgress, query: {
      'student_id': studentId,
      'semester_id': semesterId,
    });
  }

  @override
  Future<Response> downloadCertificate(
      {required int studentId, required int semesterId}) {
    return ref
        .read(apiClientProvider)
        .get(AppConstants.downloadCertificate, query: {
      'semester_id': semesterId,
      'student_id': studentId,
    });
  }
}
