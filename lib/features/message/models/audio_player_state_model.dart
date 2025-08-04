import 'package:just_audio/just_audio.dart';

class AudioState {
  final Map<String, AudioTrackState> audioStates;
  AudioState({Map<String, AudioTrackState>? audioStates})
      : audioStates = audioStates ?? {};

  AudioState copyWith({Map<String, AudioTrackState>? audioStates}) {
    return AudioState(audioStates: audioStates ?? this.audioStates);
  }
}

class AudioTrackState {
  final int duration;
  final int currentPosition;
  final bool isPlaying;
  final AudioPlayer player;

  AudioTrackState(
      {this.duration = 0,
      this.currentPosition = 0,
      this.isPlaying = false,
      required this.player});

  AudioTrackState copyWith({
    AudioPlayer? player,
    int? duration,
    int? currentPosition,
    bool? isPlaying,
  }) {
    return AudioTrackState(
      player: player ?? this.player,
      duration: duration ?? this.duration,
      currentPosition: currentPosition ?? this.currentPosition,
      isPlaying: isPlaying ?? this.isPlaying,
    );
  }
}
