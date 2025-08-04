import 'package:lms/features/parent/data/parent_repository_imp.dart';
import 'package:lms/features/parent/models/child_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'parent_controller.g.dart';

@riverpod
class ChildList extends _$ChildList {
  @override
  FutureOr<List<ChildModel>?> build() {
    return ref.read(parentRepositoryImpProvider).getChildList().then((value) {
      if (value.statusCode == 200) {
        List<dynamic> data = value.data['data']['childs'];
        return data.map((e) => ChildModel.fromJson(e)).toList();
      }
      return null;
    });
  }
}
