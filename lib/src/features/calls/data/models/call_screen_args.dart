import 'package:clone_whatsapp_round34/src/features/calls/data/models/call_model.dart';

/// Standard arguments object for both VoiceCallPage and VideoCallPage.
///
/// You can construct this in your Calls list when navigating to the pages.
class CallScreenArgs {
  final String callId; // Supabase call id, UUID, etc.
  final bool isVideo; // true => video call, false => voice call
  final bool isCaller; // true => current user initiated the call
  final CallModel call; // info to show (name, avatar, etc.)

  const CallScreenArgs({
    required this.callId,
    required this.isVideo,
    required this.isCaller,
    required this.call,
  });
}
