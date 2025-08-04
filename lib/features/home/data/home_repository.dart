import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lms/features/home/data/home_repository_imp.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'home_repository.g.dart';

@riverpod
HomeRepository homeRepository(Ref ref) {
  return HomeRepositoryImp(ref);
}

abstract class HomeRepository {
  Future<Response> getHomeData();
  Future<Response> getSubjectBasedTeacher(int subjectId);
  Future<Response> getSubjectList({int? pageNumber, int? limit, String? query});
  Future<Response> getSemesterList(
      {required int subjectId, required int teacherId});
  Future<Response> getChapterAndExamList({
    required int subjectId,
    required int teacherId,
    required int semesterId,
  });
  Future<Response> viewLesson({
    required int lessonId,
    required int teacherId,
    required chapterId,
  });

  Future<Response> rateTeacher({Map<String, dynamic>? data});
  Future<Response> getSystemSetting();
}
