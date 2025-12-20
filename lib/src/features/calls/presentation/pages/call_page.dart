import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:clone_whatsapp_round34/src/core/services/call_service.dart';
import 'package:clone_whatsapp_round34/src/features/calls/domain/repositories/call_repository.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CallPage extends StatefulWidget {
  final String channelName; // اسم الغرفة (سيكون نفس room_id الخاص بالشات)
  final String userName; // اسم الصديق
  final String callId;

  const CallPage({super.key, required this.channelName, required this.userName, required this.callId});

  @override
  State<CallPage> createState() => _CallPageState();
}

class _CallPageState extends State<CallPage> {
  final CallService _callService = CallService();
  int? _remoteUid; // لتخزين ID الطرف الآخر عندما ينضم
  bool _localUserJoined = false; // هل انضممت أنا بنجاح؟
  final CallRepository _callRepo = CallRepository();

  @override
  void initState() {
    super.initState();
    _initAgora();
    _listenToCallStatus();
  }

  // 🆕 دالة لمراقبة زر الإنهاء من الطرف الآخر
  void _listenToCallStatus() {
    Supabase.instance.client
        .from('calls')
        .stream(primaryKey: ['id'])
        .eq('id', widget.callId)
        .listen((data) {
      if (data.isNotEmpty) {
        final status = data.first['status'];
        // إذا الطرف الآخر أنهى المكالمة أو رفضها
        if (status == 'ended' || status == 'rejected') {
          if (mounted) {
             Navigator.pop(context); // نغلق الصفحة فوراً
          }
        }
      }
    });
  }

  Future<void> _initAgora() async {
    await _callService.initialize();

    // الاستماع للأحداث (Events)
    _callService.engine?.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          debugPrint("local user ${connection.localUid} joined");
          setState(() {
            _localUserJoined = true;
          });
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          debugPrint("remote user $remoteUid joined");
          setState(() {
            _remoteUid = remoteUid;
          });
        },
        onUserOffline: (RtcConnection connection, int remoteUid, UserOfflineReasonType reason) {
          debugPrint("remote user $remoteUid left");
          setState(() {
            _remoteUid = null; // نغلق فيديو الطرف الآخر
            // يمكننا إنهاء المكالمة هنا أيضاً
             Navigator.pop(context);
          });
        },
      ),
    );

    // الانضمام للغرفة (نستخدم 0 كـ ID مؤقت لي)
    await _callService.joinChannel(channelName: widget.channelName, uid: 0);
  }

  @override
  void dispose() {
    _callService.leaveChannel(); // تنظيف عند الخروج
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // 1. فيديو الطرف الآخر (ملء الشاشة)
          Center(
            child: _remoteVideo(),
          ),

          // 2. الفيديو الخاص بي (مربع صغير عائم)
          Align(
            alignment: Alignment.topRight,
            child: SizedBox(
              width: 100,
              height: 150,
              child: Center(
                child: _localUserJoined
                    ? AgoraVideoView(
                        controller: VideoViewController(
                          rtcEngine: _callService.engine!,
                          canvas: const VideoCanvas(uid: 0), // 0 تعني أنا
                        ),
                      )
                    : const CircularProgressIndicator(),
              ),
            ),
          ),

          // 3. أزرار التحكم في الأسفل
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // زر إنهاء المكالمة
                FloatingActionButton(
                  onPressed: () async {
                    await _callRepo.updateCallStatus(widget.callId, 'ended');
                    if (!context.mounted) return;
                    Navigator.pop(context);
                  },
                  backgroundColor: Colors.red,
                  child: const Icon(Icons.call_end),
                ),
              ],
            ),
          ),
          
          // اسم الشخص في الأعلى
          Positioned(
            top: 50,
            left: 20,
            child: Text(
              widget.userName,
              style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }

  // ويدجت لعرض فيديو الطرف الآخر
  Widget _remoteVideo() {
    if (_remoteUid != null) {
      return AgoraVideoView(
        controller: VideoViewController.remote(
          rtcEngine: _callService.engine!,
          canvas: VideoCanvas(uid: _remoteUid),
          connection: RtcConnection(channelId: widget.channelName),
        ),
      );
    } else {
      return const Text(
        'Waiting for friend...',
        style: TextStyle(color: Colors.white),
      );
    }
  }
}