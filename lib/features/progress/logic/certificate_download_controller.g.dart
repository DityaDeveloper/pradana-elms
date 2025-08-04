// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'certificate_download_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$certificateDownloadControllerHash() =>
    r'39ea5ae7fef98214c104ef4d5a748f39e601b341';

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

abstract class _$CertificateDownloadController
    extends BuildlessAutoDisposeAsyncNotifier<String?> {
  late final int studentId;
  late final int semesterId;

  FutureOr<String?> build({
    required int studentId,
    required int semesterId,
  });
}

/// See also [CertificateDownloadController].
@ProviderFor(CertificateDownloadController)
const certificateDownloadControllerProvider =
    CertificateDownloadControllerFamily();

/// See also [CertificateDownloadController].
class CertificateDownloadControllerFamily extends Family<AsyncValue<String?>> {
  /// See also [CertificateDownloadController].
  const CertificateDownloadControllerFamily();

  /// See also [CertificateDownloadController].
  CertificateDownloadControllerProvider call({
    required int studentId,
    required int semesterId,
  }) {
    return CertificateDownloadControllerProvider(
      studentId: studentId,
      semesterId: semesterId,
    );
  }

  @override
  CertificateDownloadControllerProvider getProviderOverride(
    covariant CertificateDownloadControllerProvider provider,
  ) {
    return call(
      studentId: provider.studentId,
      semesterId: provider.semesterId,
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
  String? get name => r'certificateDownloadControllerProvider';
}

/// See also [CertificateDownloadController].
class CertificateDownloadControllerProvider
    extends AutoDisposeAsyncNotifierProviderImpl<CertificateDownloadController,
        String?> {
  /// See also [CertificateDownloadController].
  CertificateDownloadControllerProvider({
    required int studentId,
    required int semesterId,
  }) : this._internal(
          () => CertificateDownloadController()
            ..studentId = studentId
            ..semesterId = semesterId,
          from: certificateDownloadControllerProvider,
          name: r'certificateDownloadControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$certificateDownloadControllerHash,
          dependencies: CertificateDownloadControllerFamily._dependencies,
          allTransitiveDependencies:
              CertificateDownloadControllerFamily._allTransitiveDependencies,
          studentId: studentId,
          semesterId: semesterId,
        );

  CertificateDownloadControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.studentId,
    required this.semesterId,
  }) : super.internal();

  final int studentId;
  final int semesterId;

  @override
  FutureOr<String?> runNotifierBuild(
    covariant CertificateDownloadController notifier,
  ) {
    return notifier.build(
      studentId: studentId,
      semesterId: semesterId,
    );
  }

  @override
  Override overrideWith(CertificateDownloadController Function() create) {
    return ProviderOverride(
      origin: this,
      override: CertificateDownloadControllerProvider._internal(
        () => create()
          ..studentId = studentId
          ..semesterId = semesterId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        studentId: studentId,
        semesterId: semesterId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<CertificateDownloadController,
      String?> createElement() {
    return _CertificateDownloadControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CertificateDownloadControllerProvider &&
        other.studentId == studentId &&
        other.semesterId == semesterId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, studentId.hashCode);
    hash = _SystemHash.combine(hash, semesterId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CertificateDownloadControllerRef
    on AutoDisposeAsyncNotifierProviderRef<String?> {
  /// The parameter `studentId` of this provider.
  int get studentId;

  /// The parameter `semesterId` of this provider.
  int get semesterId;
}

class _CertificateDownloadControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<
        CertificateDownloadController,
        String?> with CertificateDownloadControllerRef {
  _CertificateDownloadControllerProviderElement(super.provider);

  @override
  int get studentId =>
      (origin as CertificateDownloadControllerProvider).studentId;
  @override
  int get semesterId =>
      (origin as CertificateDownloadControllerProvider).semesterId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
