// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$homeControllerHash() => r'fdd0f30d0b2ae8654194c375c67ba2cfddb891cd';

/// See also [HomeController].
@ProviderFor(HomeController)
final homeControllerProvider =
    AsyncNotifierProvider<HomeController, HomeModel?>.internal(
  HomeController.new,
  name: r'homeControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$homeControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$HomeController = AsyncNotifier<HomeModel?>;
String _$subjectBasedTeacherHash() =>
    r'da1ad534d7c449dcb99336018aedb38dc33ec3d8';

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

abstract class _$SubjectBasedTeacher
    extends BuildlessAutoDisposeAsyncNotifier<List<Instructor>?> {
  late final int arg;

  FutureOr<List<Instructor>?> build(
    int arg,
  );
}

/// See also [SubjectBasedTeacher].
@ProviderFor(SubjectBasedTeacher)
const subjectBasedTeacherProvider = SubjectBasedTeacherFamily();

/// See also [SubjectBasedTeacher].
class SubjectBasedTeacherFamily extends Family<AsyncValue<List<Instructor>?>> {
  /// See also [SubjectBasedTeacher].
  const SubjectBasedTeacherFamily();

  /// See also [SubjectBasedTeacher].
  SubjectBasedTeacherProvider call(
    int arg,
  ) {
    return SubjectBasedTeacherProvider(
      arg,
    );
  }

  @override
  SubjectBasedTeacherProvider getProviderOverride(
    covariant SubjectBasedTeacherProvider provider,
  ) {
    return call(
      provider.arg,
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
  String? get name => r'subjectBasedTeacherProvider';
}

/// See also [SubjectBasedTeacher].
class SubjectBasedTeacherProvider extends AutoDisposeAsyncNotifierProviderImpl<
    SubjectBasedTeacher, List<Instructor>?> {
  /// See also [SubjectBasedTeacher].
  SubjectBasedTeacherProvider(
    int arg,
  ) : this._internal(
          () => SubjectBasedTeacher()..arg = arg,
          from: subjectBasedTeacherProvider,
          name: r'subjectBasedTeacherProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$subjectBasedTeacherHash,
          dependencies: SubjectBasedTeacherFamily._dependencies,
          allTransitiveDependencies:
              SubjectBasedTeacherFamily._allTransitiveDependencies,
          arg: arg,
        );

  SubjectBasedTeacherProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.arg,
  }) : super.internal();

  final int arg;

  @override
  FutureOr<List<Instructor>?> runNotifierBuild(
    covariant SubjectBasedTeacher notifier,
  ) {
    return notifier.build(
      arg,
    );
  }

  @override
  Override overrideWith(SubjectBasedTeacher Function() create) {
    return ProviderOverride(
      origin: this,
      override: SubjectBasedTeacherProvider._internal(
        () => create()..arg = arg,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        arg: arg,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<SubjectBasedTeacher,
      List<Instructor>?> createElement() {
    return _SubjectBasedTeacherProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SubjectBasedTeacherProvider && other.arg == arg;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, arg.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SubjectBasedTeacherRef
    on AutoDisposeAsyncNotifierProviderRef<List<Instructor>?> {
  /// The parameter `arg` of this provider.
  int get arg;
}

class _SubjectBasedTeacherProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<SubjectBasedTeacher,
        List<Instructor>?> with SubjectBasedTeacherRef {
  _SubjectBasedTeacherProviderElement(super.provider);

  @override
  int get arg => (origin as SubjectBasedTeacherProvider).arg;
}

String _$subjectListHash() => r'5798dde7604c43e9dcdb44f5fe04ffb82bcbd509';

/// See also [SubjectList].
@ProviderFor(SubjectList)
final subjectListProvider =
    AutoDisposeNotifierProvider<SubjectList, AsyncValue<List<Course>>>.internal(
  SubjectList.new,
  name: r'subjectListProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$subjectListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SubjectList = AutoDisposeNotifier<AsyncValue<List<Course>>>;
String _$semesterListHash() => r'6a20a7ce1041c6c00f00d56c0ba08bd7501a68c2';

abstract class _$SemesterList
    extends BuildlessAutoDisposeAsyncNotifier<SemesterModel?> {
  late final int subjectId;
  late final int teacherId;

  FutureOr<SemesterModel?> build({
    required int subjectId,
    required int teacherId,
  });
}

/// See also [SemesterList].
@ProviderFor(SemesterList)
const semesterListProvider = SemesterListFamily();

/// See also [SemesterList].
class SemesterListFamily extends Family<AsyncValue<SemesterModel?>> {
  /// See also [SemesterList].
  const SemesterListFamily();

  /// See also [SemesterList].
  SemesterListProvider call({
    required int subjectId,
    required int teacherId,
  }) {
    return SemesterListProvider(
      subjectId: subjectId,
      teacherId: teacherId,
    );
  }

  @override
  SemesterListProvider getProviderOverride(
    covariant SemesterListProvider provider,
  ) {
    return call(
      subjectId: provider.subjectId,
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
  String? get name => r'semesterListProvider';
}

/// See also [SemesterList].
class SemesterListProvider
    extends AutoDisposeAsyncNotifierProviderImpl<SemesterList, SemesterModel?> {
  /// See also [SemesterList].
  SemesterListProvider({
    required int subjectId,
    required int teacherId,
  }) : this._internal(
          () => SemesterList()
            ..subjectId = subjectId
            ..teacherId = teacherId,
          from: semesterListProvider,
          name: r'semesterListProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$semesterListHash,
          dependencies: SemesterListFamily._dependencies,
          allTransitiveDependencies:
              SemesterListFamily._allTransitiveDependencies,
          subjectId: subjectId,
          teacherId: teacherId,
        );

  SemesterListProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.subjectId,
    required this.teacherId,
  }) : super.internal();

  final int subjectId;
  final int teacherId;

  @override
  FutureOr<SemesterModel?> runNotifierBuild(
    covariant SemesterList notifier,
  ) {
    return notifier.build(
      subjectId: subjectId,
      teacherId: teacherId,
    );
  }

  @override
  Override overrideWith(SemesterList Function() create) {
    return ProviderOverride(
      origin: this,
      override: SemesterListProvider._internal(
        () => create()
          ..subjectId = subjectId
          ..teacherId = teacherId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        subjectId: subjectId,
        teacherId: teacherId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<SemesterList, SemesterModel?>
      createElement() {
    return _SemesterListProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SemesterListProvider &&
        other.subjectId == subjectId &&
        other.teacherId == teacherId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, subjectId.hashCode);
    hash = _SystemHash.combine(hash, teacherId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SemesterListRef on AutoDisposeAsyncNotifierProviderRef<SemesterModel?> {
  /// The parameter `subjectId` of this provider.
  int get subjectId;

  /// The parameter `teacherId` of this provider.
  int get teacherId;
}

class _SemesterListProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<SemesterList,
        SemesterModel?> with SemesterListRef {
  _SemesterListProviderElement(super.provider);

  @override
  int get subjectId => (origin as SemesterListProvider).subjectId;
  @override
  int get teacherId => (origin as SemesterListProvider).teacherId;
}

String _$chapterAndExamListHash() =>
    r'7e1af916cbd4719aa351b6f989314c375729bc6b';

abstract class _$ChapterAndExamList
    extends BuildlessAutoDisposeAsyncNotifier<ChapterModel?> {
  late final int subjectId;
  late final int teacherId;

  FutureOr<ChapterModel?> build({
    required int subjectId,
    required int teacherId,
  });
}

/// See also [ChapterAndExamList].
@ProviderFor(ChapterAndExamList)
const chapterAndExamListProvider = ChapterAndExamListFamily();

/// See also [ChapterAndExamList].
class ChapterAndExamListFamily extends Family<AsyncValue<ChapterModel?>> {
  /// See also [ChapterAndExamList].
  const ChapterAndExamListFamily();

  /// See also [ChapterAndExamList].
  ChapterAndExamListProvider call({
    required int subjectId,
    required int teacherId,
  }) {
    return ChapterAndExamListProvider(
      subjectId: subjectId,
      teacherId: teacherId,
    );
  }

  @override
  ChapterAndExamListProvider getProviderOverride(
    covariant ChapterAndExamListProvider provider,
  ) {
    return call(
      subjectId: provider.subjectId,
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
  String? get name => r'chapterAndExamListProvider';
}

/// See also [ChapterAndExamList].
class ChapterAndExamListProvider extends AutoDisposeAsyncNotifierProviderImpl<
    ChapterAndExamList, ChapterModel?> {
  /// See also [ChapterAndExamList].
  ChapterAndExamListProvider({
    required int subjectId,
    required int teacherId,
  }) : this._internal(
          () => ChapterAndExamList()
            ..subjectId = subjectId
            ..teacherId = teacherId,
          from: chapterAndExamListProvider,
          name: r'chapterAndExamListProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$chapterAndExamListHash,
          dependencies: ChapterAndExamListFamily._dependencies,
          allTransitiveDependencies:
              ChapterAndExamListFamily._allTransitiveDependencies,
          subjectId: subjectId,
          teacherId: teacherId,
        );

  ChapterAndExamListProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.subjectId,
    required this.teacherId,
  }) : super.internal();

  final int subjectId;
  final int teacherId;

  @override
  FutureOr<ChapterModel?> runNotifierBuild(
    covariant ChapterAndExamList notifier,
  ) {
    return notifier.build(
      subjectId: subjectId,
      teacherId: teacherId,
    );
  }

  @override
  Override overrideWith(ChapterAndExamList Function() create) {
    return ProviderOverride(
      origin: this,
      override: ChapterAndExamListProvider._internal(
        () => create()
          ..subjectId = subjectId
          ..teacherId = teacherId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        subjectId: subjectId,
        teacherId: teacherId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<ChapterAndExamList, ChapterModel?>
      createElement() {
    return _ChapterAndExamListProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ChapterAndExamListProvider &&
        other.subjectId == subjectId &&
        other.teacherId == teacherId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, subjectId.hashCode);
    hash = _SystemHash.combine(hash, teacherId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ChapterAndExamListRef
    on AutoDisposeAsyncNotifierProviderRef<ChapterModel?> {
  /// The parameter `subjectId` of this provider.
  int get subjectId;

  /// The parameter `teacherId` of this provider.
  int get teacherId;
}

class _ChapterAndExamListProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<ChapterAndExamList,
        ChapterModel?> with ChapterAndExamListRef {
  _ChapterAndExamListProviderElement(super.provider);

  @override
  int get subjectId => (origin as ChapterAndExamListProvider).subjectId;
  @override
  int get teacherId => (origin as ChapterAndExamListProvider).teacherId;
}

String _$lessonViewHash() => r'6a6e3502e138b094f2930685b21161663383e384';

abstract class _$LessonView extends BuildlessAutoDisposeAsyncNotifier<bool> {
  late final int lessonId;
  late final int teacherId;
  late final int chapterId;

  FutureOr<bool> build({
    required int lessonId,
    required int teacherId,
    required int chapterId,
  });
}

/// See also [LessonView].
@ProviderFor(LessonView)
const lessonViewProvider = LessonViewFamily();

/// See also [LessonView].
class LessonViewFamily extends Family<AsyncValue<bool>> {
  /// See also [LessonView].
  const LessonViewFamily();

  /// See also [LessonView].
  LessonViewProvider call({
    required int lessonId,
    required int teacherId,
    required int chapterId,
  }) {
    return LessonViewProvider(
      lessonId: lessonId,
      teacherId: teacherId,
      chapterId: chapterId,
    );
  }

  @override
  LessonViewProvider getProviderOverride(
    covariant LessonViewProvider provider,
  ) {
    return call(
      lessonId: provider.lessonId,
      teacherId: provider.teacherId,
      chapterId: provider.chapterId,
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
  String? get name => r'lessonViewProvider';
}

/// See also [LessonView].
class LessonViewProvider
    extends AutoDisposeAsyncNotifierProviderImpl<LessonView, bool> {
  /// See also [LessonView].
  LessonViewProvider({
    required int lessonId,
    required int teacherId,
    required int chapterId,
  }) : this._internal(
          () => LessonView()
            ..lessonId = lessonId
            ..teacherId = teacherId
            ..chapterId = chapterId,
          from: lessonViewProvider,
          name: r'lessonViewProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$lessonViewHash,
          dependencies: LessonViewFamily._dependencies,
          allTransitiveDependencies:
              LessonViewFamily._allTransitiveDependencies,
          lessonId: lessonId,
          teacherId: teacherId,
          chapterId: chapterId,
        );

  LessonViewProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.lessonId,
    required this.teacherId,
    required this.chapterId,
  }) : super.internal();

  final int lessonId;
  final int teacherId;
  final int chapterId;

  @override
  FutureOr<bool> runNotifierBuild(
    covariant LessonView notifier,
  ) {
    return notifier.build(
      lessonId: lessonId,
      teacherId: teacherId,
      chapterId: chapterId,
    );
  }

  @override
  Override overrideWith(LessonView Function() create) {
    return ProviderOverride(
      origin: this,
      override: LessonViewProvider._internal(
        () => create()
          ..lessonId = lessonId
          ..teacherId = teacherId
          ..chapterId = chapterId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        lessonId: lessonId,
        teacherId: teacherId,
        chapterId: chapterId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<LessonView, bool> createElement() {
    return _LessonViewProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is LessonViewProvider &&
        other.lessonId == lessonId &&
        other.teacherId == teacherId &&
        other.chapterId == chapterId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, lessonId.hashCode);
    hash = _SystemHash.combine(hash, teacherId.hashCode);
    hash = _SystemHash.combine(hash, chapterId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin LessonViewRef on AutoDisposeAsyncNotifierProviderRef<bool> {
  /// The parameter `lessonId` of this provider.
  int get lessonId;

  /// The parameter `teacherId` of this provider.
  int get teacherId;

  /// The parameter `chapterId` of this provider.
  int get chapterId;
}

class _LessonViewProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<LessonView, bool>
    with LessonViewRef {
  _LessonViewProviderElement(super.provider);

  @override
  int get lessonId => (origin as LessonViewProvider).lessonId;
  @override
  int get teacherId => (origin as LessonViewProvider).teacherId;
  @override
  int get chapterId => (origin as LessonViewProvider).chapterId;
}

String _$rateTeacherHash() => r'a925bb8bff92a2a577ce42a130a5a922eae66fe0';

/// See also [RateTeacher].
@ProviderFor(RateTeacher)
final rateTeacherProvider =
    AutoDisposeNotifierProvider<RateTeacher, bool>.internal(
  RateTeacher.new,
  name: r'rateTeacherProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$rateTeacherHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$RateTeacher = AutoDisposeNotifier<bool>;
String _$searchSubjectHash() => r'1fa8eef614aa4894852f9b0fc41a92717a000c3e';

/// See also [SearchSubject].
@ProviderFor(SearchSubject)
final searchSubjectProvider = AutoDisposeNotifierProvider<SearchSubject,
    AsyncValue<List<Course>>>.internal(
  SearchSubject.new,
  name: r'searchSubjectProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$searchSubjectHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SearchSubject = AutoDisposeNotifier<AsyncValue<List<Course>>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
