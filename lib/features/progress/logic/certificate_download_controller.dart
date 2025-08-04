import 'package:lms/features/progress/data/progress_repository_imp.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'certificate_download_controller.g.dart';

@riverpod
class CertificateDownloadController extends _$CertificateDownloadController {
  @override
  FutureOr<String?> build({required int studentId, required int semesterId}) {
    return ref
        .read(progressRepositoryImpProvider)
        .downloadCertificate(studentId: studentId, semesterId: semesterId)
        .then((res) {
      if (res.statusCode == 200) {
        return res.data['data']['download_url'];
      }
      return null;
    });
  }
}
