// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$countryListHash() => r'e66f51b81a1601dbd1449048b380998b2841bc3a';

/// See also [CountryList].
@ProviderFor(CountryList)
final countryListProvider =
    AutoDisposeNotifierProvider<CountryList, bool>.internal(
  CountryList.new,
  name: r'countryListProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$countryListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CountryList = AutoDisposeNotifier<bool>;
String _$cityListHash() => r'dd849b539d143837bcf68fa4c5b27b7caf421504';

/// See also [CityList].
@ProviderFor(CityList)
final cityListProvider = AutoDisposeNotifierProvider<CityList, bool>.internal(
  CityList.new,
  name: r'cityListProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$cityListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CityList = AutoDisposeNotifier<bool>;
String _$areaListHash() => r'b4cb237c1a8fd42342151f80419e9e186dcbcc40';

/// See also [AreaList].
@ProviderFor(AreaList)
final areaListProvider = AutoDisposeNotifierProvider<AreaList, bool>.internal(
  AreaList.new,
  name: r'areaListProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$areaListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AreaList = AutoDisposeNotifier<bool>;
String _$addressStoreHash() => r'd68e062cdce591fe219910d24c703877be6835b3';

/// See also [AddressStore].
@ProviderFor(AddressStore)
final addressStoreProvider =
    AutoDisposeNotifierProvider<AddressStore, bool>.internal(
  AddressStore.new,
  name: r'addressStoreProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$addressStoreHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AddressStore = AutoDisposeNotifier<bool>;
String _$addressListHash() => r'0c46ca290209d20b2126369e03b4fbefd13b9f65';

/// See also [AddressList].
@ProviderFor(AddressList)
final addressListProvider =
    AsyncNotifierProvider<AddressList, List<AddressModel>?>.internal(
  AddressList.new,
  name: r'addressListProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$addressListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AddressList = AsyncNotifier<List<AddressModel>?>;
String _$addressUpdateHash() => r'376538b7fcd764e1c6eec0cb0a249b37f2028ee4';

/// See also [AddressUpdate].
@ProviderFor(AddressUpdate)
final addressUpdateProvider =
    AutoDisposeNotifierProvider<AddressUpdate, bool>.internal(
  AddressUpdate.new,
  name: r'addressUpdateProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$addressUpdateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AddressUpdate = AutoDisposeNotifier<bool>;
String _$deleteAddressHash() => r'f30d00d933eb9bd7c91b72b77557b56b6c687fbd';

/// See also [DeleteAddress].
@ProviderFor(DeleteAddress)
final deleteAddressProvider =
    AutoDisposeNotifierProvider<DeleteAddress, bool>.internal(
  DeleteAddress.new,
  name: r'deleteAddressProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$deleteAddressHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$DeleteAddress = AutoDisposeNotifier<bool>;
String _$fAQsHash() => r'd91801d02d5bcb2beb57c349cb37b5e68333b347';

/// See also [FAQs].
@ProviderFor(FAQs)
final fAQsProvider =
    AutoDisposeAsyncNotifierProvider<FAQs, List<FaqModel>?>.internal(
  FAQs.new,
  name: r'fAQsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$fAQsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$FAQs = AutoDisposeAsyncNotifier<List<FaqModel>?>;
String _$supportHash() => r'cb9458394d716d0fd2f6d83b9e596d4030ef6ec4';

/// See also [Support].
@ProviderFor(Support)
final supportProvider = AutoDisposeNotifierProvider<Support, bool>.internal(
  Support.new,
  name: r'supportProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$supportHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Support = AutoDisposeNotifier<bool>;
String _$notificationHash() => r'3ffce60eead125771ac3d338f28b54cfd069541d';

/// See also [Notification].
@ProviderFor(Notification)
final notificationProvider = AutoDisposeAsyncNotifierProvider<Notification,
    List<NotificationModel>?>.internal(
  Notification.new,
  name: r'notificationProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$notificationHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Notification = AutoDisposeAsyncNotifier<List<NotificationModel>?>;
String _$readNotificationHash() => r'f020ea07f5ebffb4eca234b52fc06a07cec6b50f';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$ReadNotification extends BuildlessAutoDisposeNotifier<void> {
  late final int notificationId;

  void build({
    required int notificationId,
  });
}

/// See also [ReadNotification].
@ProviderFor(ReadNotification)
const readNotificationProvider = ReadNotificationFamily();

/// See also [ReadNotification].
class ReadNotificationFamily extends Family<void> {
  /// See also [ReadNotification].
  const ReadNotificationFamily();

  /// See also [ReadNotification].
  ReadNotificationProvider call({
    required int notificationId,
  }) {
    return ReadNotificationProvider(
      notificationId: notificationId,
    );
  }

  @override
  ReadNotificationProvider getProviderOverride(
    covariant ReadNotificationProvider provider,
  ) {
    return call(
      notificationId: provider.notificationId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'readNotificationProvider';
}

/// See also [ReadNotification].
class ReadNotificationProvider
    extends AutoDisposeNotifierProviderImpl<ReadNotification, void> {
  /// See also [ReadNotification].
  ReadNotificationProvider({
    required int notificationId,
  }) : this._internal(
          () => ReadNotification()..notificationId = notificationId,
          from: readNotificationProvider,
          name: r'readNotificationProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$readNotificationHash,
          dependencies: ReadNotificationFamily._dependencies,
          allTransitiveDependencies:
              ReadNotificationFamily._allTransitiveDependencies,
          notificationId: notificationId,
        );

  ReadNotificationProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.notificationId,
  }) : super.internal();

  final int notificationId;

  @override
  void runNotifierBuild(
    covariant ReadNotification notifier,
  ) {
    return notifier.build(
      notificationId: notificationId,
    );
  }

  @override
  Override overrideWith(ReadNotification Function() create) {
    return ProviderOverride(
      origin: this,
      override: ReadNotificationProvider._internal(
        () => create()..notificationId = notificationId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        notificationId: notificationId,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<ReadNotification, void> createElement() {
    return _ReadNotificationProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ReadNotificationProvider &&
        other.notificationId == notificationId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, notificationId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ReadNotificationRef on AutoDisposeNotifierProviderRef<void> {
  /// The parameter `notificationId` of this provider.
  int get notificationId;
}

class _ReadNotificationProviderElement
    extends AutoDisposeNotifierProviderElement<ReadNotification, void>
    with ReadNotificationRef {
  _ReadNotificationProviderElement(super.provider);

  @override
  int get notificationId => (origin as ReadNotificationProvider).notificationId;
}

String _$myCoursesHash() => r'9de746a6d08e426756735eedccb7f07bb54c866d';

abstract class _$MyCourses
    extends BuildlessAutoDisposeAsyncNotifier<List<MyCourseModel>> {
  late final int studentId;

  FutureOr<List<MyCourseModel>> build({
    required int studentId,
  });
}

/// See also [MyCourses].
@ProviderFor(MyCourses)
const myCoursesProvider = MyCoursesFamily();

/// See also [MyCourses].
class MyCoursesFamily extends Family<AsyncValue<List<MyCourseModel>>> {
  /// See also [MyCourses].
  const MyCoursesFamily();

  /// See also [MyCourses].
  MyCoursesProvider call({
    required int studentId,
  }) {
    return MyCoursesProvider(
      studentId: studentId,
    );
  }

  @override
  MyCoursesProvider getProviderOverride(
    covariant MyCoursesProvider provider,
  ) {
    return call(
      studentId: provider.studentId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'myCoursesProvider';
}

/// See also [MyCourses].
class MyCoursesProvider extends AutoDisposeAsyncNotifierProviderImpl<MyCourses,
    List<MyCourseModel>> {
  /// See also [MyCourses].
  MyCoursesProvider({
    required int studentId,
  }) : this._internal(
          () => MyCourses()..studentId = studentId,
          from: myCoursesProvider,
          name: r'myCoursesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$myCoursesHash,
          dependencies: MyCoursesFamily._dependencies,
          allTransitiveDependencies: MyCoursesFamily._allTransitiveDependencies,
          studentId: studentId,
        );

  MyCoursesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.studentId,
  }) : super.internal();

  final int studentId;

  @override
  FutureOr<List<MyCourseModel>> runNotifierBuild(
    covariant MyCourses notifier,
  ) {
    return notifier.build(
      studentId: studentId,
    );
  }

  @override
  Override overrideWith(MyCourses Function() create) {
    return ProviderOverride(
      origin: this,
      override: MyCoursesProvider._internal(
        () => create()..studentId = studentId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        studentId: studentId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<MyCourses, List<MyCourseModel>>
      createElement() {
    return _MyCoursesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is MyCoursesProvider && other.studentId == studentId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, studentId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin MyCoursesRef on AutoDisposeAsyncNotifierProviderRef<List<MyCourseModel>> {
  /// The parameter `studentId` of this provider.
  int get studentId;
}

class _MyCoursesProviderElement extends AutoDisposeAsyncNotifierProviderElement<
    MyCourses, List<MyCourseModel>> with MyCoursesRef {
  _MyCoursesProviderElement(super.provider);

  @override
  int get studentId => (origin as MyCoursesProvider).studentId;
}

String _$downloadCourseCertificateControllerHash() =>
    r'053857b334b3fbe1b4d0e8b3d0c0a7b16124f1f6';

abstract class _$DownloadCourseCertificateController
    extends BuildlessAutoDisposeAsyncNotifier<String?> {
  late final int studentId;
  late final int courseId;

  FutureOr<String?> build({
    required int studentId,
    required int courseId,
  });
}

/// See also [DownloadCourseCertificateController].
@ProviderFor(DownloadCourseCertificateController)
const downloadCourseCertificateControllerProvider =
    DownloadCourseCertificateControllerFamily();

/// See also [DownloadCourseCertificateController].
class DownloadCourseCertificateControllerFamily
    extends Family<AsyncValue<String?>> {
  /// See also [DownloadCourseCertificateController].
  const DownloadCourseCertificateControllerFamily();

  /// See also [DownloadCourseCertificateController].
  DownloadCourseCertificateControllerProvider call({
    required int studentId,
    required int courseId,
  }) {
    return DownloadCourseCertificateControllerProvider(
      studentId: studentId,
      courseId: courseId,
    );
  }

  @override
  DownloadCourseCertificateControllerProvider getProviderOverride(
    covariant DownloadCourseCertificateControllerProvider provider,
  ) {
    return call(
      studentId: provider.studentId,
      courseId: provider.courseId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'downloadCourseCertificateControllerProvider';
}

/// See also [DownloadCourseCertificateController].
class DownloadCourseCertificateControllerProvider
    extends AutoDisposeAsyncNotifierProviderImpl<
        DownloadCourseCertificateController, String?> {
  /// See also [DownloadCourseCertificateController].
  DownloadCourseCertificateControllerProvider({
    required int studentId,
    required int courseId,
  }) : this._internal(
          () => DownloadCourseCertificateController()
            ..studentId = studentId
            ..courseId = courseId,
          from: downloadCourseCertificateControllerProvider,
          name: r'downloadCourseCertificateControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$downloadCourseCertificateControllerHash,
          dependencies: DownloadCourseCertificateControllerFamily._dependencies,
          allTransitiveDependencies: DownloadCourseCertificateControllerFamily
              ._allTransitiveDependencies,
          studentId: studentId,
          courseId: courseId,
        );

  DownloadCourseCertificateControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.studentId,
    required this.courseId,
  }) : super.internal();

  final int studentId;
  final int courseId;

  @override
  FutureOr<String?> runNotifierBuild(
    covariant DownloadCourseCertificateController notifier,
  ) {
    return notifier.build(
      studentId: studentId,
      courseId: courseId,
    );
  }

  @override
  Override overrideWith(DownloadCourseCertificateController Function() create) {
    return ProviderOverride(
      origin: this,
      override: DownloadCourseCertificateControllerProvider._internal(
        () => create()
          ..studentId = studentId
          ..courseId = courseId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        studentId: studentId,
        courseId: courseId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<DownloadCourseCertificateController,
      String?> createElement() {
    return _DownloadCourseCertificateControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DownloadCourseCertificateControllerProvider &&
        other.studentId == studentId &&
        other.courseId == courseId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, studentId.hashCode);
    hash = _SystemHash.combine(hash, courseId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin DownloadCourseCertificateControllerRef
    on AutoDisposeAsyncNotifierProviderRef<String?> {
  /// The parameter `studentId` of this provider.
  int get studentId;

  /// The parameter `courseId` of this provider.
  int get courseId;
}

class _DownloadCourseCertificateControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<
        DownloadCourseCertificateController,
        String?> with DownloadCourseCertificateControllerRef {
  _DownloadCourseCertificateControllerProviderElement(super.provider);

  @override
  int get studentId =>
      (origin as DownloadCourseCertificateControllerProvider).studentId;
  @override
  int get courseId =>
      (origin as DownloadCourseCertificateControllerProvider).courseId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
