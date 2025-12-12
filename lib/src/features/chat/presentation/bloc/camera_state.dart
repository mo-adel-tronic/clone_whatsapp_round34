import 'package:equatable/equatable.dart';
import 'package:camera/camera.dart';


class CameraState extends Equatable {
final List<CameraDescription> cameras;
final CameraDescription? activeCamera;
final CameraController? controller;
final bool isRecording;
final bool isAudioRecording;
final FlashMode flashMode;


const CameraState({
this.cameras = const [],
this.activeCamera,
this.controller,
this.isRecording = false,
this.isAudioRecording = false,
this.flashMode = FlashMode.off,
});


CameraState copyWith({
List<CameraDescription>? cameras,
CameraDescription? activeCamera,
CameraController? controller,
bool? isRecording,
bool? isAudioRecording,
FlashMode? flashMode,
}) {
return CameraState(
cameras: cameras ?? this.cameras,
activeCamera: activeCamera ?? this.activeCamera,
controller: controller ?? this.controller,
isRecording: isRecording ?? this.isRecording,
isAudioRecording: isAudioRecording ?? this.isAudioRecording,
flashMode: flashMode ?? this.flashMode,
);
}


@override
List<Object?> get props => [cameras, activeCamera, controller, isRecording, isAudioRecording, flashMode];
}