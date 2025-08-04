import 'package:lms/features/academic_info/models/academic_info_model/country.dart';
import 'package:lms/features/profile/data/profile_repository_imp.dart';
import 'package:lms/features/profile/models/address_model.dart';
import 'package:lms/features/profile/models/area_model.dart';
import 'package:lms/features/profile/models/city_model.dart';
import 'package:lms/features/profile/models/faq_model.dart';
import 'package:lms/features/profile/models/my_course_model.dart';
import 'package:lms/features/profile/models/notification_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'profile_controller.g.dart';

@riverpod
class CountryList extends _$CountryList {
  @override
  bool build() {
    return false;
  }

  Future<List<Country>?> getCountryList() {
    state = true;
    return ref.read(profileRepositoryImpProvider).getCountryList().then((res) {
      if (res.statusCode == 200) {
        List<dynamic> dataList = res.data['data']['countries'];
        List<Country> countryList =
            dataList.map((e) => Country.fromMap(e)).toList();
        return countryList;
      }
      return null;
    }).catchError((e) {
      state = false;
      return null;
    }).whenComplete(() => state = false);
  }
}

@riverpod
class CityList extends _$CityList {
  @override
  bool build() {
    return false;
  }

  Future<List<CityModel>?> getCityList({required int countryId}) {
    state = true;
    return ref
        .read(profileRepositoryImpProvider)
        .getCityList(countryId)
        .then((res) {
      if (res.statusCode == 200) {
        List<dynamic> dataList = res.data['data']['states'];
        List<CityModel> cityList =
            dataList.map((e) => CityModel.fromMap(e)).toList();
        return cityList;
      }
      return null;
    }).catchError((e) {
      state = false;
      return null;
    }).whenComplete(() => state = false);
  }
}

@riverpod
class AreaList extends _$AreaList {
  @override
  bool build() {
    return false;
  }

  Future<List<AreaModel>?> getAreaList({required int cityId}) {
    state = true;
    return ref
        .read(profileRepositoryImpProvider)
        .getAreaList(cityId)
        .then((res) {
      if (res.statusCode == 200) {
        List<dynamic> dataList = res.data['data']['cities'];
        List<AreaModel> areaList =
            dataList.map((e) => AreaModel.fromMap(e)).toList();
        return areaList;
      }
      return null;
    }).catchError((e) {
      state = false;
      return null;
    }).whenComplete(() => state = false);
  }
}

@riverpod
class AddressStore extends _$AddressStore {
  @override
  bool build() {
    return false;
  }

  Future<bool> storeAddress(Map<String, dynamic> data) {
    state = true;
    return ref
        .read(profileRepositoryImpProvider)
        .storeAddress(data)
        .then((res) {
      if (res.statusCode == 200) {
        state = false;
        return true;
      }
      state = false;
      return false;
    }).catchError((e) {
      state = false;
      return false;
    }).whenComplete(() => state = false);
  }
}

@Riverpod(keepAlive: true)
class AddressList extends _$AddressList {
  @override
  FutureOr<List<AddressModel>?> build() {
    return ref.read(profileRepositoryImpProvider).getAddressList().then((res) {
      if (res.statusCode == 200) {
        List<dynamic> dataList = res.data['data']['addresses'];
        List<AddressModel> addressList =
            dataList.map((e) => AddressModel.fromMap(e)).toList();
        return addressList;
      }
      return null;
    });
  }
}

@riverpod
class AddressUpdate extends _$AddressUpdate {
  @override
  bool build() {
    return false;
  }

  Future<bool> updateAddress(Map<String, dynamic> data) {
    state = true;
    return ref
        .read(profileRepositoryImpProvider)
        .updateAddress(data)
        .then((res) {
      if (res.statusCode == 200) {
        state = false;
        return true;
      }
      state = false;
      return false;
    }).catchError((e) {
      state = false;
      return false;
    }).whenComplete(() => state = false);
  }
}

@riverpod
class DeleteAddress extends _$DeleteAddress {
  @override
  bool build() {
    return false;
  }

  Future<bool> deleteAddress(int addressId) {
    state = true;
    return ref
        .read(profileRepositoryImpProvider)
        .deleteAddress(addressId)
        .then((res) {
      if (res.statusCode == 200) {
        state = false;
        return true;
      }
      state = false;
      return false;
    }).catchError((e) {
      state = false;
      return false;
    }).whenComplete(() => state = false);
  }
}

@riverpod
class FAQs extends _$FAQs {
  @override
  FutureOr<List<FaqModel>?> build() {
    return ref.read(profileRepositoryImpProvider).getFaqList().then((res) {
      if (res.statusCode == 200) {
        List<dynamic> dataList = res.data['data']['faqs'];
        List<FaqModel> faqList =
            dataList.map((e) => FaqModel.fromMap(e)).toList();
        return faqList;
      }
      return null;
    });
  }
}

@riverpod
class Support extends _$Support {
  @override
  bool build() {
    return false;
  }

  Future<bool> support({Map<String, dynamic>? data}) {
    state = true;
    return ref
        .read(profileRepositoryImpProvider)
        .support(data: data)
        .then((res) {
      if (res.statusCode == 200) {
        state = false;
        return true;
      }
      state = false;
      return false;
    }).catchError((e) {
      state = false;
      return false;
    }).whenComplete(() => state = false);
  }
}

@riverpod
class Notification extends _$Notification {
  @override
  FutureOr<List<NotificationModel>?> build() {
    return ref
        .read(profileRepositoryImpProvider)
        .getNotificationList()
        .then((res) {
      if (res.statusCode == 200) {
        List<dynamic> dataList = res.data['data']['notifications'];
        List<NotificationModel> notificationList =
            dataList.map((e) => NotificationModel.fromMap(e)).toList();
        return notificationList;
      }
      return null;
    });
  }
}

@riverpod
class ReadNotification extends _$ReadNotification {
  @override
  void build({required int notificationId}) {
    ref
        .read(profileRepositoryImpProvider)
        .readNotification(notificationId: notificationId)
        .then((res) {
      if (res.statusCode == 200) {
        ref.invalidate(notificationProvider);
      }
    });
  }
}

@riverpod
class MyCourses extends _$MyCourses {
  @override
  FutureOr<List<MyCourseModel>> build({required int studentId}) async {
    return await ref
        .read(profileRepositoryImpProvider)
        .getSubjectList(
          pageNumber: 1,
          limit: 100,
          studentId: studentId,
        )
        .then((res) {
      if (res.statusCode == 200) {
        List<dynamic> dataList = res.data['data']['courses'] == null ||
                res.data['data']['courses'].isEmpty
            ? []
            : res.data['data']['courses'];
        List<MyCourseModel> courseList =
            dataList.map((e) => MyCourseModel.fromMap(e)).toList();
        return courseList;
      }
      return [];
    });
  }
}

@riverpod
class DownloadCourseCertificateController
    extends _$DownloadCourseCertificateController {
  @override
  FutureOr<String?> build({required int studentId, required int courseId}) {
    return ref
        .read(profileRepositoryImpProvider)
        .downloadCourseCertificate(studentId: studentId, courseId: courseId)
        .then((res) {
      if (res.statusCode == 200) {
        return res.data['data']['download_url'];
      }
      return null;
    });
  }
}
