import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lms/core/constants/app_constants.dart';
import 'package:lms/features/parent/data/parent_repository.dart';
import 'package:lms/utils/api_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'parent_repository_imp.g.dart';

@riverpod
ParentRepositoryImp parentRepositoryImp(ParentRepositoryImpRef ref) {
  return ParentRepositoryImp(ref);
}

class ParentRepositoryImp implements ParentRepository {
  final Ref ref;
  ParentRepositoryImp(this.ref);

  @override
  Future<Response> getChildList() {
    return ref.read(apiClientProvider).get(AppConstants.childList);
  }
}
