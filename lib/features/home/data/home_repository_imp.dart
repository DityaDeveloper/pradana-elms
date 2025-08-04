import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lms/core/constants/app_constants.dart';
import 'package:lms/features/home/data/home_repository.dart';
import 'package:lms/utils/api_client.dart';

class HomeRepositoryImp implements HomeRepository {
  HomeRepositoryImp(this.ref);

  final Ref ref;

  @override
  Future<Response> getHomeData() {
    return ref.read(apiClientProvider).get(AppConstants.home);
  }

  @override
  Future<Response> getSubjectBasedTeacher(int subjectId) {
    return ref
        .read(apiClientProvider)
        .get(AppConstants.subjectBasedTeacher, query: {'course_id': subjectId});
  }

  @override
  Future<Response> getSubjectList(
      {int? pageNumber, int? limit, String? query}) {
    return ref.read(apiClientProvider).get(AppConstants.subjectList, query: {
      'page_number': pageNumber,
      'items_per_page': limit,
      "search": query,
    });
  }

  @override
  Future<Response> getSemesterList(
      {required int subjectId, required int teacherId}) {
    return ref.read(apiClientProvider).get(AppConstants.semesterList,
        query: {'course_id': subjectId, 'instructor_id': teacherId});
  }

  @override
  Future<Response> getChapterAndExamList(
      {required int subjectId,
      required int teacherId,
      required int semesterId}) {
    return ref.read(apiClientProvider).get(AppConstants.chapterAndExamList,
        query: {
          'course_id': subjectId,
          'instructor_id': teacherId,
          'semester_id': semesterId
        });
  }

  @override
  Future<Response> viewLesson(
      {required int lessonId, required int teacherId, required chapterId}) {
    return ref.read(apiClientProvider).post(AppConstants.lessonView, data: {
      'lesson_id': lessonId,
      'instructor_id': teacherId,
      'chapter_id': chapterId
    });
  }

  @override
  Future<Response> rateTeacher({Map<String, dynamic>? data}) {
    return ref
        .read(apiClientProvider)
        .post(AppConstants.teacherRating, data: data);
  }

  @override
  Future<Response> getSystemSetting() {
    return ref.read(apiClientProvider).get(AppConstants.systemSetting);
  }
}
