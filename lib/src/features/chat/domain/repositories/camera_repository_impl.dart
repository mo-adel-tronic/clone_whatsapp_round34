import 'package:camera/camera.dart';
import 'package:clone_whatsapp_round34/src/features/chat/domain/repositories/camera_repository.dart';

class CameraRepositoryImpl implements CameraRepository {
@override
Future<List<CameraDescription>> getAvailableCameras() => availableCameras();


@override
Future<void> initialize(CameraController controller) async {
if (!controller.value.isInitialized) {
await controller.initialize();
}
}


@override
Future<XFile> takePhoto(CameraController controller) async {
return await controller.takePicture();
}


@override
Future<void> startVideoRecording(CameraController controller) async {
await controller.startVideoRecording();
}


@override
Future<XFile> stopVideoRecording(CameraController controller) async {
return await controller.stopVideoRecording();
}
}
