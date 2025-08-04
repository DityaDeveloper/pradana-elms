import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lms/features/message/models/message_model.dart';
import 'package:lms/services/local_storage_service.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class SocketService {
  static final SocketService _instance = SocketService._internal();

  factory SocketService() {
    return _instance;
  }
  SocketService._internal();

  late io.Socket socket;
  final StreamController<MessageModel> _newMessageStream =
      StreamController.broadcast();

  Stream<MessageModel> get newMessageStream => _newMessageStream.stream;

  void conntectToSocket() async {
    final int? userId =
        await LocalStorageService().getUser().then((value) => value.id);

    try {
      socket = io.io(
        'https://bridgelms.razinsoft.com:8100',
        io.OptionBuilder()
            .setTransports(['websocket']).setQuery({'userId': userId}).build(),
      );
      socket.connect();
    } catch (e) {
      debugPrint(e.toString());
    }
    socket.on('connect', (_) {
      debugPrint('connected');
    });

    socket.on('new-message', (data) {
      debugPrint('message event triggered: $data');
      try {
        final messageMap = Map<String, dynamic>.from(data);

        // parse the messageMap to a MessageModel object
        final message = MessageModel.fromMap(messageMap);
        _newMessageStream.add(message);
      } catch (e) {
        print('error: $e');
        rethrow;
      }
    });

    socket.on('message-status-updated', (data) {
      debugPrint('message-status-updated: $data');
    });

    socket.on('error', (data) {
      debugPrint('error: $data');
    });
  }

  void sendMessage(MessageModel message) {
    socket.emit('new-message', message);
  }

  void disConnect() {
    _newMessageStream.close();
    socket.dispose();
  }
}
