import 'package:permission_handler/permission_handler.dart';


class PermissionsService {
Future<bool> requestCameraPermission() async {
final status = await Permission.camera.request();
return status.isGranted;
}


Future<bool> requestMicrophonePermission() async {
final status = await Permission.microphone.request();
return status.isGranted;
}


Future<bool> requestStoragePermission() async {
final status = await Permission.storage.request();
return status.isGranted;
}


Future<bool> requestAll() async {
final results = await Future.wait([
Permission.camera.request(),
Permission.microphone.request(),
Permission.storage.request(),
]);
return results.every((r) => r.isGranted);
}
}