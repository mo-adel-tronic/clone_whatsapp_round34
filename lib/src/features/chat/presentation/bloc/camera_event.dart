import 'package:equatable/equatable.dart';


abstract class CameraEvent extends Equatable {
@override
List<Object?> get props => [];
}


class InitCamerasEvent extends CameraEvent {}
class SwitchCameraEvent extends CameraEvent {}
class ToggleFlashEvent extends CameraEvent {}
class TakePhotoEvent extends CameraEvent {}
class StartVideoEvent extends CameraEvent {}
class StopVideoEvent extends CameraEvent {}
class StartAudioRecordEvent extends CameraEvent {}
class StopAudioRecordEvent extends CameraEvent {}