// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teacher_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$teacherListHash() => r'4879f30e4bd4edfab79ae2f11f602e212a6c3d05';

/// See also [TeacherList].
@ProviderFor(TeacherList)
final teacherListProvider = AutoDisposeNotifierProvider<TeacherList,
    AsyncValue<List<Instructor>>>.internal(
  TeacherList.new,
  name: r'teacherListProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$teacherListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$TeacherList = AutoDisposeNotifier<AsyncValue<List<Instructor>>>;
String _$teacherDetailsHash() => r'4d9fc2f3469c0e04322ed3487de027bd59b83caa';

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

abstract class _$TeacherDetails
    extends BuildlessAutoDisposeAsyncNotifier<TeacherDetailsModel?> {
  late final int teacherId;

  FutureOr<TeacherDetailsModel?> build({
    required int teacherId,
  });
}

/// See also [TeacherDetails].
@ProviderFor(TeacherDetails)
const teacherDetailsProvider = TeacherDetailsFamily();

/// See also [TeacherDetails].
class TeacherDetailsFamily extends Family<AsyncValue<TeacherDetailsModel?>> {
  /// See also [TeacherDetails].
  const TeacherDetailsFamily();

  /// See also [TeacherDetails].
  TeacherDetailsProvider call({
    required int teacherId,
  }) {
    return TeacherDetailsProvider(
      teacherId: teacherId,
    );
  }

  @override
  TeacherDetailsProvider getProviderOverride(
    covariant TeacherDetailsProvider provider,
  ) {
    return call(
      teacherId: provider.teacherId,
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
  String? get name => r'teacherDetailsProvider';
}

/// See also [TeacherDetails].
class TeacherDetailsProvider extends AutoDisposeAsyncNotifierProviderImpl<
    TeacherDetails, TeacherDetailsModel?> {
  /// See also [TeacherDetails].
  TeacherDetailsProvider({
    required int teacherId,
  }) : this._internal(
          () => TeacherDetails()..teacherId = teacherId,
          from: teacherDetailsProvider,
          name: r'teacherDetailsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$teacherDetailsHash,
          dependencies: TeacherDetailsFamily._dependencies,
          allTransitiveDependencies:
              TeacherDetailsFamily._allTransitiveDependencies,
          teacherId: teacherId,
        );

  TeacherDetailsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.teacherId,
  }) : super.internal();

  final int teacherId;

  @override
  FutureOr<TeacherDetailsModel?> runNotifierBuild(
    covariant TeacherDetails notifier,
  ) {
    return notifier.build(
      teacherId: teacherId,
    );
  }

  @override
  Override overrideWith(TeacherDetails Function() create) {
    return ProviderOverride(
      origin: this,
      override: TeacherDetailsProvider._internal(
        () => create()..teacherId = teacherId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        teacherId: teacherId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<TeacherDetails, TeacherDetailsModel?>
      createElement() {
    return _TeacherDetailsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TeacherDetailsProvider && other.teacherId == teacherId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, teacherId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin TeacherDetailsRef
    on AutoDisposeAsyncNotifierProviderRef<TeacherDetailsModel?> {
  /// The parameter `teacherId` of this provider.
  int get teacherId;
}

class _TeacherDetailsProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<TeacherDetails,
        TeacherDetailsModel?> with TeacherDetailsRef {
  _TeacherDetailsProviderElement(super.provider);

  @override
  int get teacherId => (origin as TeacherDetailsProvider).teacherId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
