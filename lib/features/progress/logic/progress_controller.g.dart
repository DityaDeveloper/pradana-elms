// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'progress_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$studentProgressHash() => r'31382b484f6ed2b127a7a379da5e084612cfe0a1';

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

abstract class _$StudentProgress
    extends BuildlessAutoDisposeAsyncNotifier<ProgressModel?> {
  late final int studentId;
  late final int? semesterId;

  FutureOr<ProgressModel?> build(
    int studentId,
    int? semesterId,
  );
}

/// See also [StudentProgress].
@ProviderFor(StudentProgress)
const studentProgressProvider = StudentProgressFamily();

/// See also [StudentProgress].
class StudentProgressFamily extends Family<AsyncValue<ProgressModel?>> {
  /// See also [StudentProgress].
  const StudentProgressFamily();

  /// See also [StudentProgress].
  StudentProgressProvider call(
    int studentId,
    int? semesterId,
  ) {
    return StudentProgressProvider(
      studentId,
      semesterId,
    );
  }

  @override
  StudentProgressProvider getProviderOverride(
    covariant StudentProgressProvider provider,
  ) {
    return call(
      provider.studentId,
      provider.semesterId,
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
  String? get name => r'studentProgressProvider';
}

/// See also [StudentProgress].
class StudentProgressProvider extends AutoDisposeAsyncNotifierProviderImpl<
    StudentProgress, ProgressModel?> {
  /// See also [StudentProgress].
  StudentProgressProvider(
    int studentId,
    int? semesterId,
  ) : this._internal(
          () => StudentProgress()
            ..studentId = studentId
            ..semesterId = semesterId,
          from: studentProgressProvider,
          name: r'studentProgressProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$studentProgressHash,
          dependencies: StudentProgressFamily._dependencies,
          allTransitiveDependencies:
              StudentProgressFamily._allTransitiveDependencies,
          studentId: studentId,
          semesterId: semesterId,
        );

  StudentProgressProvider._internal(
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
  final int? semesterId;

  @override
  FutureOr<ProgressModel?> runNotifierBuild(
    covariant StudentProgress notifier,
  ) {
    return notifier.build(
      studentId,
      semesterId,
    );
  }

  @override
  Override overrideWith(StudentProgress Function() create) {
    return ProviderOverride(
      origin: this,
      override: StudentProgressProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<StudentProgress, ProgressModel?>
      createElement() {
    return _StudentProgressProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is StudentProgressProvider &&
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
mixin StudentProgressRef
    on AutoDisposeAsyncNotifierProviderRef<ProgressModel?> {
  /// The parameter `studentId` of this provider.
  int get studentId;

  /// The parameter `semesterId` of this provider.
  int? get semesterId;
}

class _StudentProgressProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<StudentProgress,
        ProgressModel?> with StudentProgressRef {
  _StudentProgressProviderElement(super.provider);

  @override
  int get studentId => (origin as StudentProgressProvider).studentId;
  @override
  int? get semesterId => (origin as StudentProgressProvider).semesterId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
