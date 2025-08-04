class AudioRecorderStateModel {
  final String? path;
  final bool isRecording;

  AudioRecorderStateModel({this.path, this.isRecording = false});

  AudioRecorderStateModel copyWith({
    String? path,
    bool? isRecording,
  }) {
    return AudioRecorderStateModel(
      path: path ?? this.path,
      isRecording: isRecording ?? this.isRecording,
    );
  }
}
