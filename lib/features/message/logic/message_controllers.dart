import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lms/features/message/logic/providers.dart';
import 'package:lms/features/message/models/message_model.dart';
import 'package:lms/features/message/models/send_message_model.dart';
import 'package:lms/services/socket_service.dart';

class MessageControllerNotifier extends StateNotifier<List<MessageModel>> {
  final Ref ref;
  MessageControllerNotifier(this.ref) : super([]) {
    _initialize();
  }

  // Initialize both API and socket communication
  void _initialize() async {
    // Fetch messages from the API

    SocketService().conntectToSocket();
    SocketService().newMessageStream.listen((event) {
      debugPrint('message event triggered: $event');
      _handleNewMessage(event);
    });
  }

  void _handleNewMessage(MessageModel message) {
    state = [message, ...state];
  }

  void addMessage(MessageModel message, int instuctorId) async {
    SendMessageModel sendMessageModel = SendMessageModel(
      instructorId: instuctorId,
      text: message.text,
      type: message.type ?? 'text',
      media: message.media,
      senderType: message.senderType,
      questionDetailsModel: message.questionDetailsModel,
    );
    state = [message, ...state];
    await ref
        .read(messageRepositoryProvider)
        .sendMessage(message: sendMessageModel);
  }

  void getMessages({required int instuctorId, int? page}) async {
    final apiMessages = await ref
        .read(messageRepositoryProvider)
        .getMessages(instuctorId: instuctorId, page: page);
    if (page == 1) {
      state = apiMessages.item1.reversed.toList();
      ref.read(totalMessageCountProvider.notifier).state = apiMessages.item2;
    } else {
      state = [...state, ...apiMessages.item1.reversed];
    }
  }

  void clearMessages() {
    state = [];
  }
}

class PickedImageControllerNotifier extends StateNotifier<String?> {
  PickedImageControllerNotifier() : super(null);
  void selectImage(String image) {
    state = image;
  }

  void removeImage() {
    state = null;
  }
}
