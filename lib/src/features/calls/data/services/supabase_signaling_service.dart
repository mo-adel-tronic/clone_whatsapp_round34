import 'package:supabase_flutter/supabase_flutter.dart';

typedef SignalCallback = void Function(Map<String, dynamic> data);

/// Wrapper around Supabase Realtime for WebRTC signaling (offer/answer/ice/hangup).
/// Uses ONLY APIs that exist in your supabase_flutter version:
/// - client.channel('topic')
/// - channel.onBroadcast(event: ..., callback: ...)
/// - channel.sendBroadcastMessage(event: ..., payload: ...)
/// - client.removeChannel(channel)
class SupabaseSignalingService {
  SupabaseSignalingService(this._client);

  final SupabaseClient _client;

  RealtimeChannel? _channel;
  SignalCallback? onSignal;

  /// Join (or create) a realtime channel for a specific call.
  ///
  /// Example: callId = "123" -> topic "call_123".
  Future<void> joinCallChannel(String callId) async {
    await leaveChannel();

    final channel = _client.channel('call_$callId');
    _channel = channel;

    // Listen for broadcast messages with event 'signal'
    channel.onBroadcast(
      event: 'signal',
      callback: (Map<String, dynamic> payload) {
        // We send our signaling data as the payload itself.
        onSignal?.call(payload);
      },
    );

    // Subscribe
    await channel.subscribe();
  }

  /// Send a signaling message to the current channel.
  Future<void> sendSignal(Map<String, dynamic> data) async {
    final channel = _channel;
    if (channel == null) return;

    await channel.sendBroadcastMessage(
      event: 'signal',
      payload: data,
    );
  }

  /// Leave the realtime channel.
  Future<void> leaveChannel() async {
    final channel = _channel;
    if (channel != null) {
      await _client.removeChannel(channel);
      _channel = null;
    }
  }
}
