import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:lms/features/message/models/audio_player_state_model.dart';

class AudioPlayerControllerNotifer extends StateNotifier<AudioState> {
  final Ref ref;
  AudioPlayerControllerNotifer(this.ref) : super(AudioState());

  final AudioPlayer player = AudioPlayer();

  // Play audio from [Uint8List]
  Future<void> playAudio({
    required String? url,
    bool isLocal = false,
    required String messageId,
  }) async {
    try {
      // If no existing player for this messageId, create one
      final currentState = state.audioStates[messageId];
      final player = currentState?.player ?? AudioPlayer();
      if (isLocal) {
        await player.setFilePath(url!);
      } else {
        await player.setAudioSource(
          AudioSource.uri(
            Uri.parse(
              url!,
            ),
          ),
        );
      }

      // Update the state with a new player and mark it as playing
      state = state.copyWith(audioStates: {
        ...state.audioStates,
        messageId: currentState?.copyWith(player: player, isPlaying: true) ??
            AudioTrackState(player: player, isPlaying: true),
      });

      // Play the audio
      player.play();

      // Track progress
      player.positionStream.listen((position) {
        final duration = player.duration;
        state = state.copyWith(audioStates: {
          ...state.audioStates,
          messageId: state.audioStates[messageId]?.copyWith(
                duration: duration?.inMilliseconds,
                currentPosition: position.inMilliseconds,
                isPlaying: player.playing,
              ) ??
              AudioTrackState(
                player: player,
                duration: duration?.inMilliseconds ?? 0,
                currentPosition: position.inMilliseconds,
                isPlaying: player.playing,
              ),
        });
      });

      // Listen for player state changes
      player.playerStateStream.listen((playerState) {
        if (playerState.processingState == ProcessingState.completed) {
          player.stop();
          state = state.copyWith(audioStates: {
            ...state.audioStates,
            messageId: state.audioStates[messageId]?.copyWith(
                    isPlaying: false, player: player, currentPosition: 0) ??
                AudioTrackState(player: player, isPlaying: false),
          });
        }
      });
    } catch (e) {
      debugPrint('Audio Playback Error: $e');
    }
  }

  /// Pause audio playback
  Future<void> pauseAudio({required String messageId}) async {
    try {
      player.pause();
      player.positionStream.listen((position) {
        state = state.copyWith(audioStates: {
          ...state.audioStates,
          messageId: state.audioStates[messageId]?.copyWith(
                  isPlaying: false, currentPosition: position.inMilliseconds) ??
              AudioTrackState(
                isPlaying: false,
                currentPosition: position.inMilliseconds,
                player: player,
              )
        });
      });
    } catch (e) {
      debugPrint('Audio Playback Error: $e');
    }
  }

  /// Stop audio playback
  Future<void> stopAudio({
    required String messageId,
    required AudioPlayer player,
  }) async {
    try {
      await player.stop();
      state = state.copyWith(audioStates: {
        ...state.audioStates,
        messageId: state.audioStates[messageId]
                ?.copyWith(isPlaying: false, currentPosition: 0) ??
            AudioTrackState(
                isPlaying: false, currentPosition: 0, player: player)
      });
    } catch (e) {
      debugPrint('Audio Playback Error: $e');
    }
  }
}
