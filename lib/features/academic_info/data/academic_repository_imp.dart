import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lms/core/constants/app_constants.dart';
import 'package:lms/features/academic_info/data/academic_repository.dart';
import 'package:lms/utils/api_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'academic_repository_imp.g.dart';

@riverpod
AcademicRepositoryImp academicRepositoryImp(AcademicRepositoryImpRef ref) {
  return AcademicRepositoryImp(ref);
}

class AcademicRepositoryImp implements AcademicRepository {
  final Ref ref;
  AcademicRepositoryImp(this.ref);

  @override
  Future<Response> getAcademicInfo() {
    return ref.read(apiClientProvider).get(AppConstants.academicInfoList);
  }

  @override
  Future<Response> storeAcademicInfo(Map<String, dynamic> data) {
    return ref
        .read(apiClientProvider)
        .post(AppConstants.academicInfoStore, data: data);
  }
}
