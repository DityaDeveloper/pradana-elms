import 'package:hive_flutter/hive_flutter.dart';
import 'package:lms/core/constants/app_constants.dart';
import 'package:lms/features/academic_info/data/academic_repository_imp.dart';
import 'package:lms/features/academic_info/models/academic_info_model/academic_info_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'academic_controller.g.dart';

@riverpod
class AcademicInfoList extends _$AcademicInfoList {
  @override
  Future<AcademicInfoModel> build() async {
    final response =
        await ref.read(academicRepositoryImpProvider).getAcademicInfo();

    if (response.statusCode == 200) {
      return AcademicInfoModel.fromMap(response.data);
    } else {
      throw Exception('Failed to fetch academic information');
    }
  }
}

@riverpod
class AcademicInfoStore extends _$AcademicInfoStore {
  @override
  bool build() {
    return false;
  }

  Future<bool> store(Map<String, dynamic> data) async {
    state = true;
    final response =
        await ref.read(academicRepositoryImpProvider).storeAcademicInfo(data);
    if (response.statusCode == 200) {
      Box authBox = Hive.box(AppConstants.authBox);
      authBox.put(AppConstants.academinInfoData,
          response.data['data']['academic_info']);
      state = false;
      return true;
    } else {
      state = false;
      return false;
    }
  }
}
