import 'package:clone_whatsapp_round34/src/features/calls/data/services/supabase_signaling_service.dart';
import 'package:clone_whatsapp_round34/src/features/calls/data/services/webrtc_service.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

enum CallSide { caller, callee }

/// Orchestrates WebRTC + Supabase signaling.
/// Voice and video pages use this controller.
class CallController {
  CallController({
    required this.signaling,
    required this.webrtc,
    required this.currentUserId,
  });

  final SupabaseSignalingService signaling;
  final WebRtcService webrtc;
  final String currentUserId;

  late final String callId;
  late final bool isVideo;
  late final CallSide side;

  MediaStream? get localStream => webrtc.localStream;
  Stream<MediaStream> get remoteStreamStream => webrtc.remoteStreamStream;

  Future<void> initAsCaller({
    required String newCallId,
    required bool isVideoCall,
  }) async {
    callId = newCallId;
    isVideo = isVideoCall;
    side = CallSide.caller;

    await signaling.joinCallChannel(callId);
    signaling.onSignal = _onSignalReceived;

    await webrtc.init(isVideo: isVideo);
    webrtc.onIceCandidate = _sendIceCandidate;

    final offer = await webrtc.createOffer();
    await signaling.sendSignal({
      'type': 'offer',
      'from': currentUserId,
      'sdp': offer.sdp,
      'sdpType': offer.type,
      'isVideo': isVideo,
    });
  }

  Future<void> initAsCallee({
    required String existingCallId,
    required bool isVideoCall,
  }) async {
    callId = existingCallId;
    isVideo = isVideoCall;
    side = CallSide.callee;

    await signaling.joinCallChannel(callId);
    signaling.onSignal = _onSignalReceived;

    await webrtc.init(isVideo: isVideo);
    webrtc.onIceCandidate = _sendIceCandidate;
    // Wait for 'offer' in _onSignalReceived.
  }

  Future<void> _onSignalReceived(Map<String, dynamic> data) async {
    final type = data['type'] as String?;
    if (type == null) return;

    switch (type) {
      case 'offer':
        await webrtc.setRemoteDescription(
          data['sdp'] as String,
          data['sdpType'] as String? ?? 'offer',
        );
        final answer = await webrtc.createAnswer();
        await signaling.sendSignal({
          'type': 'answer',
          'from': currentUserId,
          'sdp': answer.sdp,
          'sdpType': answer.type,
        });
        break;
      case 'answer':
        await webrtc.setRemoteDescription(
          data['sdp'] as String,
          data['sdpType'] as String? ?? 'answer',
        );
        break;
      case 'ice':
        final cand = data['candidate'] as Map<String, dynamic>;
        await webrtc.addRemoteCandidate(cand);
        break;
      case 'hangup':
        await dispose();
        break;
    }
  }

  Future<void> _sendIceCandidate(RTCIceCandidate cand) async {
    await signaling.sendSignal({
      'type': 'ice',
      'from': currentUserId,
      'candidate': {
        'candidate': cand.candidate,
        'sdpMid': cand.sdpMid,
        'sdpMLineIndex': cand.sdpMLineIndex,
      },
    });
  }

  Future<void> hangup() async {
    await signaling.sendSignal({
      'type': 'hangup',
      'from': currentUserId,
    });
    await dispose();
  }

  Future<void> dispose() async {
    await webrtc.dispose();
    await signaling.leaveChannel();
  }
}
