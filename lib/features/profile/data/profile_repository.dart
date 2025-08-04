import 'package:dio/dio.dart';

abstract class ProfileRepository {
  Future<Response> getCountryList();
  Future<Response> getCityList(int countryId);
  Future<Response> getAreaList(int cityId);
  // address
  Future<Response> storeAddress(Map<String, dynamic> data);
  Future<Response> getAddressList();
  Future<Response> updateAddress(Map<String, dynamic> data);
  Future<Response> deleteAddress(int addressId);

  Future<Response> getFaqList();
  Future<Response> support({Map<String, dynamic>? data});

  Future<Response> getNotificationList();
  Future<Response> readNotification({required int notificationId});

  Future<Response> getSubjectList(
      {int? pageNumber, int? limit, int? studentId});

  Future<Response> downloadCourseCertificate(
      {required int studentId, required int courseId});
}
