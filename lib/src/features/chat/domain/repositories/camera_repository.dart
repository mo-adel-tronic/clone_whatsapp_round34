import 'package:camera/camera.dart';


abstract class CameraRepository {
Future<List<CameraDescription>> getAvailableCameras();
Future<void> initialize(CameraController controller);
Future<XFile> takePhoto(CameraController controller);
Future<void> startVideoRecording(CameraController controller);
Future<XFile> stopVideoRecording(CameraController controller);
}