import 'package:clone_whatsapp_round34/src/features/calls/domain/repositories/call_repository.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'call_page.dart'; // صفحة الفيديو التي أنشأناها سابقاً

class IncomingCallPage extends StatefulWidget {
  final String callId;
  final String callerName;
  final String? callerAvatar;
  final String channelId;

  const IncomingCallPage({
    super.key,
    required this.callId,
    required this.callerName,
    required this.callerAvatar,
    required this.channelId,
  });

  @override
  State<IncomingCallPage> createState() => _IncomingCallPageState();
}

class _IncomingCallPageState extends State<IncomingCallPage> {
  @override
  void initState() {
    super.initState();
    _listenToCallCancellation();
  }

  void _listenToCallCancellation() {
    Supabase.instance.client
        .from('calls')
        .stream(primaryKey: ['id'])
        .eq('id', widget.callId) // نستمع لنفس المكالمة
        .listen((data) {
      if (data.isNotEmpty) {
        final status = data.first['status'];
        // إذا المتصل ألغى المكالمة (ended)
        if (status == 'ended') {
          if (mounted) Navigator.pop(context); // إغلاق الشاشة
        }
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    final CallRepository callRepo = CallRepository();

    return Scaffold(
      backgroundColor: Colors.blueGrey[900], // خلفية داكنة
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // 1. بيانات المتصل
            Column(
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundImage: widget.callerAvatar != null 
                      ? NetworkImage(widget.callerAvatar!) 
                      : null,
                  child: widget.callerAvatar == null 
                      ? const Icon(Icons.person, size: 60) 
                      : null,
                ),
                const SizedBox(height: 20),
                Text(
                  widget.callerName,
                  style: const TextStyle(
                    fontSize: 28, 
                    color: Colors.white, 
                    fontWeight: FontWeight.bold
                  ),
                ),
                const Text(
                  "Incoming Video Call...",
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
              ],
            ),

            // 2. أزرار التحكم (رد / رفض)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // زر الرفض
                FloatingActionButton(
                  heroTag: "decline",
                  backgroundColor: Colors.red,
                  onPressed: () async {
                    // تحديث الحالة لـ rejected وإغلاق الشاشة
                    await callRepo.updateCallStatus(widget.callId, 'rejected');
                    if (context.mounted) Navigator.pop(context);
                  },
                  child: const Icon(Icons.call_end, color: Colors.white),
                ),

                // زر القبول
                FloatingActionButton(
                  heroTag: "accept",
                  backgroundColor: Colors.green,
                  onPressed: () async {
                    // 1. تحديث الحالة لـ accepted
                    await callRepo.updateCallStatus(widget.callId, 'accepted');
                    
                    if (context.mounted) {
                      // 2. إغلاق شاشة الرنين
                      Navigator.pop(context); 
                      
                      // 3. الانتقال لصفحة الفيديو الحقيقية
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CallPage(
                            channelName: widget.channelId, 
                            userName: widget.callerName,
                            callId: widget.callId,
                          ),
                        ),
                      );
                    }
                  },
                  child: const Icon(Icons.videocam, color: Colors.white),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}