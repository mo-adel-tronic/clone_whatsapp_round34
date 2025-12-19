import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

/// Encapsulates WebRTC peer connection and local/remote media.
class WebRtcService {
  RTCPeerConnection? _pc;
  MediaStream? _localStream;

  final _remoteStreamController = StreamController<MediaStream>.broadcast();
  Stream<MediaStream> get remoteStreamStream => _remoteStreamController.stream;

  MediaStream? get localStream => _localStream;

  /// Called whenever a new ICE candidate is discovered.
  ValueChanged<RTCIceCandidate>? onIceCandidate;

  Future<void> init({required bool isVideo}) async {
    final configuration = <String, dynamic>{
      'iceServers': [
        {'urls': 'stun:stun.l.google.com:19302'},
      ],
    };

    final constraints = <String, dynamic>{
      'mandatory': {},
      'optional': [
        {'DtlsSrtpKeyAgreement': true},
      ],
    };

    _pc = await createPeerConnection(configuration, constraints);

    _pc!.onIceCandidate = (candidate) {
      if (candidate != null) {
        onIceCandidate?.call(candidate);
      }
    };

    _pc!.onTrack = (RTCTrackEvent event) {
      if (event.streams.isNotEmpty) {
        _remoteStreamController.add(event.streams[0]);
      }
    };

    final mediaConstraints = <String, dynamic>{
      'audio': true,
      'video': isVideo
          ? {
              'facingMode': 'user',
            }
          : false,
    };

    _localStream = await navigator.mediaDevices.getUserMedia(mediaConstraints);

    for (final track in _localStream!.getTracks()) {
      await _pc!.addTrack(track, _localStream!);
    }
  }

  Future<RTCSessionDescription> createOffer() async {
    final offer = await _pc!.createOffer();
    await _pc!.setLocalDescription(offer);
    return offer;
  }

  Future<RTCSessionDescription> createAnswer() async {
    final answer = await _pc!.createAnswer();
    await _pc!.setLocalDescription(answer);
    return answer;
  }

  Future<void> setRemoteDescription(String sdp, String type) async {
    final description = RTCSessionDescription(sdp, type);
    await _pc!.setRemoteDescription(description);
  }

  Future<void> addRemoteCandidate(Map<String, dynamic> cand) async {
    final candidate = RTCIceCandidate(
      cand['candidate'] as String,
      cand['sdpMid'] as String?,
      cand['sdpMLineIndex'] as int?,
    );
    await _pc!.addCandidate(candidate);
  }

  Future<void> dispose() async {
    await _localStream?.dispose();
    await _pc?.close();
    await _pc?.dispose();
    await _remoteStreamController.close();
  }
}
