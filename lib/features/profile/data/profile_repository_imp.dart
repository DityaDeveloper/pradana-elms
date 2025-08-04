import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lms/core/constants/app_constants.dart';
import 'package:lms/features/profile/data/profile_repository.dart';
import 'package:lms/utils/api_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'profile_repository_imp.g.dart';

@riverpod
ProfileRepositoryImp profileRepositoryImp(ProfileRepositoryImpRef ref) {
  return ProfileRepositoryImp(ref);
}

class ProfileRepositoryImp implements ProfileRepository {
  final Ref ref;
  ProfileRepositoryImp(this.ref);

  @override
  Future<Response> getCountryList() {
    return ref.read(apiClientProvider).get(AppConstants.countryList);
  }

  @override
  Future<Response> getCityList(int countryId) {
    return ref
        .read(apiClientProvider)
        .get(AppConstants.cityList, query: {'country_id': countryId});
  }

  @override
  Future<Response> getAreaList(int cityId) {
    return ref
        .read(apiClientProvider)
        .get(AppConstants.areaList, query: {'state_id': cityId});
  }

  @override
  Future<Response> storeAddress(Map<String, dynamic> data) {
    return ref
        .read(apiClientProvider)
        .post(AppConstants.addressStore, queryParameters: data);
  }

  @override
  Future<Response> getAddressList() {
    return ref.read(apiClientProvider).get(AppConstants.addressList);
  }

  @override
  Future<Response> updateAddress(Map<String, dynamic> data) {
    return ref
        .read(apiClientProvider)
        .post(AppConstants.addressUpdate, queryParameters: data);
  }

  @override
  Future<Response> deleteAddress(int addressId) {
    return ref
        .read(apiClientProvider)
        .get(AppConstants.addressDelete, query: {'address_id': addressId});
  }

  @override
  Future<Response> getFaqList() {
    return ref.read(apiClientProvider).get(AppConstants.faqList);
  }

  @override
  Future<Response> support({Map<String, dynamic>? data}) {
    return ref.read(apiClientProvider).post(AppConstants.support, data: data);
  }

  @override
  Future<Response> getNotificationList() {
    return ref.read(apiClientProvider).get(AppConstants.notificationList);
  }

  @override
  Future<Response> readNotification({required int notificationId}) {
    return ref.read(apiClientProvider).get(AppConstants.readNotification,
        query: {'notification_id': notificationId});
  }

  @override
  Future<Response> getSubjectList(
      {int? pageNumber, int? limit, int? studentId}) {
    return ref.read(apiClientProvider).get(AppConstants.myCourses, query: {
      'page_number': pageNumber,
      'items_per_page': limit,
      'student_id': studentId,
    });
  }

  @override
  Future<Response> downloadCourseCertificate(
      {required int studentId, required int courseId}) {
    return ref
        .read(apiClientProvider)
        .get(AppConstants.downloadCourseCertificate, query: {
      'student_id': studentId,
      'course_id': courseId,
    });
  }
}
