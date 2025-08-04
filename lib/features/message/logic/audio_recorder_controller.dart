import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lms/features/message/models/audio_recorder_state_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

class AudioRecorderControllerNotifer
    extends StateNotifier<AudioRecorderStateModel> {
  final Ref ref;

  AudioRecorderControllerNotifer(this.ref) : super(AudioRecorderStateModel());

  final _recorder = AudioRecorder();

  bool _isRecorderInitialized = false;

  // /// Initialize the recorder and player
  // Future<void> init() async {
  //   if (!_isRecorderInitialized) {

  //     _isRecorderInitialized = true;
  //   }
  // }

  // Dispose the recorder, player, and subscriptions

  Future<void> disposeResources() async {
    if (_isRecorderInitialized) {
      await _recorder.dispose();
      _isRecorderInitialized = false;
    }
  }

  /// Start recording audio
  Future<void> startRecording({String? filePath}) async {
    state = state.copyWith(isRecording: true);

    try {
      if (filePath == null) {
        final directory = await getTemporaryDirectory();
        filePath = '${directory.path}/audio_temp.aac';
      }
      await _recorder.start(const RecordConfig(), path: filePath);
    } on Exception catch (e) {
      debugPrint('Failed to start recording: $e');
    }
  }

  /// Stop recording and return the audio as [Uint8List]
  Future<void> stopRecording() async {
    try {
      String? path = await _recorder.stop();
      state = state.copyWith(isRecording: false);

      final File audioFile = File(path!);
      print('Audio file size: ${audioFile.lengthSync()} bytes');
      final file = _saveBytesToFile(audioFile.readAsBytesSync());
      final filePath = await file.then((value) => value.path);
      state = state.copyWith(path: filePath);
      print('Temporary file path: $filePath');
    } on Exception catch (e) {
      debugPrint('Failed to stop recording: $e');
    }

    return;
  }

  // Save Unit8List as a temporary file

  Future<File> _saveBytesToFile(Uint8List bytes) async {
    try {
      // Get the temporary directory
      final tempDir = await getTemporaryDirectory();

      // Create a unique filename using the current timestamp
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final fileName = 'audio_$timestamp.aac';

      final tempFile = File('${tempDir.path}/$fileName');
      await tempFile.writeAsBytes(bytes);
      // Check if the directory exists; if not, create it
      if (!(await tempFile.parent.exists())) {
        await tempFile.parent.create(recursive: true);
      }
      await tempFile.writeAsBytes(bytes);

      return tempFile;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  void removeAudio() {
    print('removing audio');
    state = AudioRecorderStateModel(path: null, isRecording: false);
  }
}
