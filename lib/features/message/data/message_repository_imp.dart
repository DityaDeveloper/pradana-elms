import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lms/core/constants/app_constants.dart';
import 'package:lms/features/message/data/message_repository.dart';
import 'package:lms/features/message/models/message_model.dart';
import 'package:lms/features/message/models/send_message_model.dart';
import 'package:lms/utils/api_client.dart';
import 'package:tuple/tuple.dart';

class MessageRepositoryImp extends MessageRepository {
  final Ref ref;
  MessageRepositoryImp(this.ref);
  @override
  Future<bool> sendMessage({required SendMessageModel message}) async {
    // Convert message to a map and remove unwanted keys
    final messageMap = message.toMap()
      ..removeWhere((key, value) => {'instructor_id', 'media'}.contains(key));

    final formData = FormData.fromMap({
      ...messageMap,
      if (message.media != null)
        'media': await MultipartFile.fromFile(message.media!),
    });
    try {
      final response = await ref
          .read(apiClientProvider)
          .post(AppConstants.sendMessage, data: formData, queryParameters: {
        'instructor_id': message.instructorId,
      });
      return response.statusCode == 200;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Tuple2<List<MessageModel>, int>> getMessages(
      {required int instuctorId, int? page}) async {
    try {
      final response = await ref.read(apiClientProvider).get(
          AppConstants.messageList,
          query: {'instructor_id': instuctorId, 'page': page});
      if (response.statusCode == 200) {
        final List<dynamic> messages = response.data['data']['messages'];
        final List<MessageModel> messageList = messages
            .map<MessageModel>((message) => MessageModel.fromMap(message))
            .toList();
        return Tuple2(messageList, response.data['data']['total_items']);
      }
      return const Tuple2([], 0);
    } catch (e) {
      rethrow;
    }
  }
}
