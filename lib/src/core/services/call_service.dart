import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:permission_handler/permission_handler.dart';

class CallService {
  // 🔴 استبدل هذا بالـ App ID الخاص بك من موقع Agora
  static const String appId = "232fe89f67084933ad1b91d3d9853636";
  
  RtcEngine? _engine;

  // تهيئة المحرك
  Future<void> initialize() async {
    // طلب الأذونات أولاً
    await [Permission.microphone, Permission.camera].request();

    if (_engine != null) return;

    // إنشاء المحرك
    _engine = createAgoraRtcEngine();
    await _engine!.initialize(const RtcEngineContext(
      appId: appId,
      channelProfile: ChannelProfileType.channelProfileCommunication,
    ));

    // تفعيل الفيديو
    await _engine!.enableVideo();
    await _engine!.startPreview();
  }

  // الانضمام لقناة (مكالمة)
  Future<void> joinChannel({required String channelName, required int uid}) async {
    await _engine?.joinChannel(
      token: "", // اتركها فارغة إذا كنت تستخدم App ID only
      channelId: channelName,
      uid: uid, // 0 يعني دع Agora تختار ID عشوائي لي، أو ضع رقمك
      options: const ChannelMediaOptions(
        clientRoleType: ClientRoleType.clientRoleBroadcaster, // أنا متصل ولست مشاهداً
      ),
    );
  }

  // إغلاق المكالمة وتنظيف الموارد
  Future<void> leaveChannel() async {
    await _engine?.leaveChannel();
    await _engine?.release();
    _engine = null;
  }
  
  // دالة للحصول على المحرك لاستخدامه في الـ UI
  RtcEngine? get engine => _engine;
}