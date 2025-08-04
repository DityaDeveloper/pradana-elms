import 'package:lms/features/home/data/home_repository.dart';
import 'package:lms/features/home/logic/providers.dart';
import 'package:lms/features/home/models/home_model/course.dart';
import 'package:lms/features/home/models/home_model/home_model.dart';
import 'package:lms/features/home/models/home_model/instructor.dart';
import 'package:lms/features/message/logic/providers.dart';
import 'package:lms/features/semesters/models/chapter_model/chapter_model.dart';
import 'package:lms/features/semesters/models/semester_model/semester_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_controller.g.dart';

@Riverpod(keepAlive: true)
class HomeController extends _$HomeController {
  @override
  FutureOr<HomeModel?> build() async {
    return ref.read(homeRepositoryProvider).getHomeData().then((value) {
      if (value.statusCode == 200) {
        return HomeModel.fromMap(value.data);
      }
      return null;
    });
  }
}

@riverpod
class SubjectBasedTeacher extends _$SubjectBasedTeacher {
  @override
  FutureOr<List<Instructor>?> build(int arg) async {
    return ref
        .read(homeRepositoryProvider)
        .getSubjectBasedTeacher(arg)
        .then((res) {
      if (res.statusCode == 200) {
        List<dynamic> data = res.data['data']['instructors'];
        return data.map((e) => Instructor.fromMap(e)).toList();
      } else {
        return null;
      }
    });
  }
}

@riverpod
class SubjectList extends _$SubjectList {
  int _currentPage = 2;
  bool isLastPage = false;

  @override
  AsyncValue<List<Course>> build() {
    return const AsyncData([]);
  }

  void loadMore() {
    if (state.isLoading || isLastPage) return;
    ref
        .read(homeRepositoryProvider)
        .getSubjectList(pageNumber: _currentPage, limit: 8)
        .then((res) {
      if (res.statusCode == 200) {
        List<dynamic> data = res.data['data']['courses'];
        List<Course> newCourses = data.map((e) => Course.fromMap(e)).toList();

        // Check for duplicates and only add unique courses
        if (newCourses.isEmpty) {
          isLastPage = true; // Mark as last page if no new courses are fetched
          print('No more data to load. Marking as last page.');
        } else {
          final List<Course> currentCourses = state.value ?? [];
          final Set<int?> currentCourseIds =
              currentCourses.map((course) => course.id).toSet();
          final List<Course> uniqueCourses = newCourses
              .where((course) => !currentCourseIds.contains(course.id))
              .toList();

          // Update the state with unique courses
          state = AsyncData([...currentCourses, ...uniqueCourses]);
          _currentPage++;
        }
      } else {
        state = AsyncError('Failed to load courses', StackTrace.current);
      }
    }).catchError((error, stackTrace) {
      state = AsyncError(error, stackTrace);
    });
  }

  Future<void> searchSubject({required String query}) async {
    // Set the state to loading before starting the search
    state = const AsyncValue.loading();

    try {
      final res = await ref
          .read(homeRepositoryProvider)
          .getSubjectList(query: query, pageNumber: 1, limit: 8);

      if (res.statusCode == 200) {
        List<dynamic> data = res.data['data']['courses'];
        List<Course> courses = data.map((e) => Course.fromMap(e)).toList();

        // Update the state with the list of courses
        state = AsyncValue.data(courses);
        _currentPage = 2;
        isLastPage = false;
      } else {
        // Handle error by setting state to AsyncValue.error
        state = AsyncValue.error('Failed to load courses', StackTrace.current);
      }
    } catch (e, stackTrace) {
      // Handle exceptions by setting state to AsyncValue.error
      state = AsyncValue.error(e, stackTrace);
    }
  }
}

@riverpod
class SemesterList extends _$SemesterList {
  @override
  FutureOr<SemesterModel?> build(
      {required int subjectId, required int teacherId}) async {
    return ref
        .read(homeRepositoryProvider)
        .getSemesterList(subjectId: subjectId, teacherId: teacherId)
        .then((res) {
      if (res.statusCode == 200) {
        SemesterModel model = SemesterModel.fromMap(res.data);
        if (ref.read(selectedSemesterIDProvider) == null) {
          ref.read(selectedSemesterIDProvider.notifier).state =
              model.data?.semesters?.first.id;
          ref.read(selectedSemesterTitleProvider.notifier).state =
              model.data?.semesters?.first.title;
          ref
              .read(questionDetailsControllerProvider.notifier)
              .update((state) => state.copyWith(
                    semester: model.data?.semesters?.first.title,
                  ));
        }
        // detect last semester is unlocked or not
        if (model.data?.semesters?.last.isLocked == false) {
          ref.read(isLockedLastSemesterProvider.notifier).state = false;
        } else {
          ref.read(isLockedLastSemesterProvider.notifier).state = true;
        }
        return model;
      }
      return null;
    });
  }
}

@riverpod
class ChapterAndExamList extends _$ChapterAndExamList {
  @override
  FutureOr<ChapterModel?> build(
      {required int subjectId, required int teacherId}) async {
    final semesterId = ref.watch(selectedSemesterIDProvider);
    // loading
    const AsyncLoading();
    await Future.delayed(const Duration(seconds: 1));
    final res = await ref.read(homeRepositoryProvider).getChapterAndExamList(
        subjectId: subjectId, teacherId: teacherId, semesterId: semesterId!);
    if (res.statusCode == 200) {
      return ChapterModel.fromMap(res.data);
    }
    return null;
  }
}

@riverpod
class LessonView extends _$LessonView {
  @override
  FutureOr<bool> build(
      {required int lessonId,
      required int teacherId,
      required int chapterId}) async {
    return ref
        .read(homeRepositoryProvider)
        .viewLesson(
            lessonId: lessonId, teacherId: teacherId, chapterId: chapterId)
        .then((res) {
      if (res.statusCode == 200) {
        return true;
      }
      return false;
    });
  }
}

@riverpod
class RateTeacher extends _$RateTeacher {
  @override
  bool build() {
    return false;
  }

  Future<bool> rateTeacher(Map<String, dynamic> data) async {
    final res = await ref.read(homeRepositoryProvider).rateTeacher(data: data);
    if (res.statusCode == 200) {
      return true;
    }
    return false;
  }
}

@riverpod
class SearchSubject extends _$SearchSubject {
  @override
  AsyncValue<List<Course>> build() {
    // Initialize with AsyncValue.loading to indicate loading state
    return const AsyncData([]);
  }

  Future<void> searchSubject({required String query}) async {
    // Set the state to loading before starting the search
    state = const AsyncValue.loading();

    try {
      final res =
          await ref.read(homeRepositoryProvider).getSubjectList(query: query);

      if (res.statusCode == 200) {
        List<dynamic> data = res.data['data']['courses'];
        List<Course> courses = data.map((e) => Course.fromMap(e)).toList();

        // Update the state with the list of courses
        state = AsyncValue.data(courses);
      } else {
        // Handle error by setting state to AsyncValue.error
        state = AsyncValue.error('Failed to load courses', StackTrace.current);
      }
    } catch (e, stackTrace) {
      // Handle exceptions by setting state to AsyncValue.error
      state = AsyncValue.error(e, stackTrace);
    }
  }
}
