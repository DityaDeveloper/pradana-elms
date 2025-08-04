import 'package:lms/features/message/models/message_model.dart';
import 'package:lms/features/message/models/send_message_model.dart';
import 'package:tuple/tuple.dart';

abstract class MessageRepository {
  Future<void> sendMessage({required SendMessageModel message});
  Future<Tuple2<List<MessageModel>, int>> getMessages({
    required int instuctorId,
    int? page,
  });
}
