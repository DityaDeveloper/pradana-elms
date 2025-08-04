import 'package:lms/features/teachers/data/teacher_repository_imp.dart';
import 'package:lms/features/teachers/models/teacher_details_model/instructor.dart';
import 'package:lms/features/teachers/models/teacher_details_model/teacher_details_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'teacher_controller.g.dart';

@riverpod
class TeacherList extends _$TeacherList {
  int _currentPage = 2;
  bool isLastPage = false;
  @override
  AsyncValue<List<Instructor>> build() {
    return const AsyncData([]);
  }

  void loadMore() {
    if (state.isLoading || isLastPage) return;
    ref
        .read(teacherRepositoryImpProvider)
        .getTeachersList(pageNumber: _currentPage, limit: 8)
        .then((res) {
      if (res.statusCode == 200) {
        List<dynamic> data = res.data['data']['instructors'];
        List<Instructor> newInstructor =
            data.map((e) => Instructor.fromMap(e)).toList();

        // Check for duplicates and only add unique courses
        if (newInstructor.isEmpty) {
          isLastPage = true; // Mark as last page if no new courses are fetched
          print('No more data to load. Marking as last page.');
        } else {
          final List<Instructor> currentInstructor = state.value ?? [];
          final Set<int?> currentInstructorIds =
              currentInstructor.map((course) => course.id).toSet();
          final List<Instructor> uniqueInstructor = newInstructor
              .where((course) => !currentInstructorIds.contains(course.id))
              .toList();

          // Update the state with unique courses
          state = AsyncData([...currentInstructor, ...uniqueInstructor]);
          _currentPage++;
        }
      } else {
        state = AsyncError('Failed to load instructor', StackTrace.current);
      }
    }).catchError((error, stackTrace) {
      state = AsyncError(error, stackTrace);
    });
  }

  Future<void> searchTeacher({required String query}) async {
    // Set the state to loading before starting the search
    state = const AsyncLoading();

    try {
      final res = await ref
          .read(teacherRepositoryImpProvider)
          .getTeachersList(query: query, pageNumber: 1, limit: 8);

      if (res.statusCode == 200) {
        List<dynamic> data = res.data['data']['instructors'];
        final teachers = data.map((e) => Instructor.fromMap(e)).toList();
        state = AsyncData(teachers);
        _currentPage = 2;
        isLastPage = false;
      } else {
        // Handle error by setting state to AsyncError
        state = AsyncValue.error('Failed to load courses', StackTrace.current);
      }
    } catch (e, stackTrace) {
      // Optionally log the error
      print('Error fetching teacher list: $e');
      state = AsyncValue.error(e, stackTrace);
      // Propagate the exception so Riverpod can handle it
      rethrow;
    }
  }
}

@riverpod
class TeacherDetails extends _$TeacherDetails {
  @override
  FutureOr<TeacherDetailsModel?> build({required int teacherId}) {
    return ref
        .read(teacherRepositoryImpProvider)
        .getTeacherDetails(id: teacherId)
        .then((res) {
      if (res.statusCode == 200) {
        return TeacherDetailsModel.fromMap(res.data);
      } else {
        return null;
      }
    }).catchError((e) {
      // Optionally log the error
      print('Error fetching teacher details: $e');
      // Propagate the exception so Riverpod can handle it
      throw e;
    }).whenComplete(() {
      // Optionally do something when the future completes
    });
  }
}
