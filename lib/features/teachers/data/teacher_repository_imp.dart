import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lms/core/constants/app_constants.dart';
import 'package:lms/features/teachers/data/teacher_repository.dart';
import 'package:lms/utils/api_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'teacher_repository_imp.g.dart';

@riverpod
TeacherRepositoryImp teacherRepositoryImp(TeacherRepositoryImpRef ref) {
  return TeacherRepositoryImp(ref);
}

class TeacherRepositoryImp extends TeacherRepository {
  final Ref ref;
  TeacherRepositoryImp(this.ref);

  @override
  Future<Response> getTeachersList(
      {int? pageNumber, int? limit, String? query}) {
    return ref.read(apiClientProvider).get(AppConstants.teacherList, query: {
      'page_number': pageNumber,
      'items_per_page': limit,
      "search": query,
    });
  }

  @override
  Future<Response> getTeacherDetails({required int id}) {
    return ref
        .read(apiClientProvider)
        .get(AppConstants.teacherDetails, query: {"instructor_id": id});
  }
}
