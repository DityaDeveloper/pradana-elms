import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lms/features/message/data/message_repository.dart';
import 'package:lms/features/message/data/message_repository_imp.dart';
import 'package:lms/features/message/logic/audio_player_controller.dart';
import 'package:lms/features/message/logic/audio_recorder_controller.dart';
import 'package:lms/features/message/logic/message_controllers.dart';
import 'package:lms/features/message/models/audio_player_state_model.dart';
import 'package:lms/features/message/models/audio_recorder_state_model.dart';
import 'package:lms/features/message/models/message_model.dart';
import 'package:lms/features/message/models/question_details_model.dart';

// repo providers
final messageRepositoryProvider = Provider<MessageRepository>((ref) {
  return MessageRepositoryImp(ref);
});

final messageControllerProvider =
    StateNotifierProvider<MessageControllerNotifier, List<MessageModel>>((ref) {
  return MessageControllerNotifier(ref);
});

final pickedImageControllerProvider =
    StateNotifierProvider<PickedImageControllerNotifier, String?>(
        (ref) => PickedImageControllerNotifier());

final showDownButtonProvider = StateProvider<bool>((ref) => false);

final totalMessageCountProvider = StateProvider<int>((ref) => 0);

final audioPlayerControllerProvider =
    StateNotifierProvider<AudioPlayerControllerNotifer, AudioState?>(
        (ref) => AudioPlayerControllerNotifer(ref));

final audioRecorderControllerProvider = StateNotifierProvider<
    AudioRecorderControllerNotifer,
    AudioRecorderStateModel?>((ref) => AudioRecorderControllerNotifer(ref));

final questionDetailsControllerProvider =
    StateProvider<QuestionDetailsModel>((ref) => QuestionDetailsModel.empty());
