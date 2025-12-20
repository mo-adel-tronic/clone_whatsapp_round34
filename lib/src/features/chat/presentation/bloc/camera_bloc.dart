import 'dart:async';
import 'package:camera/camera.dart';
import 'package:clone_whatsapp_round34/src/core/services/services.dart';
import 'package:clone_whatsapp_round34/src/features/chat/domain/repositories/camera_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'camera_event.dart';
import 'camera_state.dart';
import 'package:flutter_sound/flutter_sound.dart';
//TODO: Why using path provider and path?
// import 'package:path_provider/path_provider.dart';
// import 'package:path/path.dart' as p;

class CameraBloc extends Bloc<CameraEvent, CameraState> {
  final CameraRepository cameraRepository;
  final PermissionsService permissionsService;

  FlutterSoundRecorder? _audioRecorder;
  String? _audioPath;

  CameraBloc({required this.cameraRepository, required this.permissionsService})
      : super(const CameraState()) {
    on<InitCamerasEvent>(_onInit);
    on<SwitchCameraEvent>(_onSwitch);
    on<ToggleFlashEvent>(_onToggleFlash);
    on<TakePhotoEvent>(_onTakePhoto);
    on<StartVideoEvent>(_onStartVideo);
    on<StopVideoEvent>(_onStopVideo);
    on<StartAudioRecordEvent>(_onStartAudio);
    on<StopAudioRecordEvent>(_onStopAudio);
  }

  Future<void> _onInit(
      InitCamerasEvent event, Emitter<CameraState> emit) async {
    final granted = await permissionsService.requestAll();
    if (!granted) return;

    final cameras = await cameraRepository.getAvailableCameras();
    if (cameras.isEmpty) return;

    final controller = CameraController(cameras.first, ResolutionPreset.high,
        enableAudio: true);
    await cameraRepository.initialize(controller);

    emit(state.copyWith(
        cameras: cameras, activeCamera: cameras.first, controller: controller));
  }

  Future<void> _onSwitch(
      SwitchCameraEvent event, Emitter<CameraState> emit) async {
    final current = state.activeCamera;
    if (current == null) return;
    final others = state.cameras.where((c) => c.name != current.name).toList();
    if (others.isEmpty) return;

    final newCam = others.first;
    await state.controller?.dispose();
    final controller =
        CameraController(newCam, ResolutionPreset.high, enableAudio: true);
    await cameraRepository.initialize(controller);

    emit(state.copyWith(activeCamera: newCam, controller: controller));
  }

  Future<void> _onToggleFlash(
      ToggleFlashEvent event, Emitter<CameraState> emit) async {
    final controller = state.controller;
    if (controller == null) return;
    final current = state.flashMode;
    final next = current == FlashMode.off ? FlashMode.always : FlashMode.off;
    await controller.setFlashMode(next);
    emit(state.copyWith(flashMode: next));
  }

  Future<void> _onTakePhoto(
      TakePhotoEvent event, Emitter<CameraState> emit) async {
    final controller = state.controller;
    if (controller == null) return;
  }

  Future<void> _onStartVideo(
      StartVideoEvent event, Emitter<CameraState> emit) async {
    final controller = state.controller;
    if (controller == null) return;
    await controller.startVideoRecording();
    emit(state.copyWith(isRecording: true));
  }

  Future<void> _onStopVideo(
      StopVideoEvent event, Emitter<CameraState> emit) async {
    final controller = state.controller;
    if (controller == null) return;
    await controller.stopVideoRecording();
    emit(state.copyWith(isRecording: false));
  }

  Future<void> _onStartAudio(
      StartAudioRecordEvent event, Emitter<CameraState> emit) async {
    _audioRecorder = FlutterSoundRecorder();
    await _audioRecorder?.openRecorder();
    await _audioRecorder?.startRecorder(toFile: _audioPath);
    emit(state.copyWith(isAudioRecording: true));
  }

  Future<void> _onStopAudio(
      StopAudioRecordEvent event, Emitter<CameraState> emit) async {
    await _audioRecorder?.stopRecorder();
    await _audioRecorder?.closeRecorder();
    emit(state.copyWith(isAudioRecording: false));
  }
}
