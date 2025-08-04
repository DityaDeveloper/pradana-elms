import 'package:lms/features/progress/data/progress_repository_imp.dart';
import 'package:lms/features/progress/logic/providers.dart';
import 'package:lms/features/progress/models/progress_model/progress_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'progress_controller.g.dart';

@Riverpod(keepAlive: false)
class StudentProgress extends _$StudentProgress {
  @override
  FutureOr<ProgressModel?> build(int studentId, int? semesterId) {
    return ref
        .read(progressRepositoryImpProvider)
        .getProgressInfo(studentId: studentId, semesterId: semesterId)
        .then(
      (value) {
        if (value.statusCode == 200) {
          final progressModel = ProgressModel.fromMap(value.data);
          if (ref.read(selectedProgressSemesterProvider.notifier).state ==
              null) {
            ref.read(selectedProgressSemesterProvider.notifier).state =
                progressModel.data?.semesters?.first;
          }
          return progressModel;
        }
        return null;
      },
    );
  }
}
