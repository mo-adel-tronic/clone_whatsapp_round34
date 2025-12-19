import 'package:clone_whatsapp_round34/src/features/calls/data/controller/call_controller.dart';
import 'package:clone_whatsapp_round34/src/features/calls/data/services/supabase_signaling_service.dart';
import 'package:clone_whatsapp_round34/src/features/calls/data/services/webrtc_service.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:clone_whatsapp_round34/src/features/calls/data/models/call_model.dart';

class VoiceCallPage extends StatefulWidget {
  const VoiceCallPage({super.key});

  @override
  State<VoiceCallPage> createState() => _VoiceCallPageState();
}

class _VoiceCallPageState extends State<VoiceCallPage> {
  late CallModel _call;
  late String _displayName;
  String? _avatarUrl;

  CallController? _controller;
  bool _logicInitialized = false;

  Duration _elapsed = Duration.zero;
  Ticker? _ticker;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_logicInitialized) return;

    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is CallModel) {
      _call = args;
    } else {
      // Fallback dummy
      _call = CallModel(
        id: 'local',
        name: 'Unknown contact',
        avatarUrl: "",
        isVerified: false,
        lastCallTime: 'Now',
        bgImgUrl: '',
        isVideoCall: false,
        isIncoming: false,
        isMissed: false,
        timeLabel: '',
      );
    }

    _displayName = _call.name ?? 'Unknown contact';
    _avatarUrl = _call.avatarUrl;

    _initCallLogic();
    _logicInitialized = true;
  }

  Future<void> _initCallLogic() async {
    // Init controller (this side is caller for now)
    final supabase = Supabase.instance.client;
    final signaling = SupabaseSignalingService(supabase);
    final webrtc = WebRtcService();

    final controller = CallController(
      signaling: signaling,
      webrtc: webrtc,
      currentUserId: 'CURRENT_USER_ID', // TODO: replace with real user id
    );

    _controller = controller;

    final callId = _call.id ?? 'call_${DateTime.now().millisecondsSinceEpoch}';

    await controller.initAsCaller(
      newCallId: callId,
      isVideoCall: false,
    );

    // Start fake duration timer
    _ticker = Ticker((elapsed) {
      if (!mounted) return;
      setState(() => _elapsed = elapsed);
    })
      ..start();
  }

  @override
  void dispose() {
    _ticker?.dispose();
    _controller?.hangup(); // ignore future
    super.dispose();
  }

  String get _elapsedText {
    final mm = _elapsed.inMinutes.remainder(60).toString().padLeft(2, '0');
    final ss = _elapsed.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$mm:$ss';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8E3DC),
      body: Stack(
        children: [
          // Background doodle image
          Positioned.fill(
            child: Image.asset(
              'assets/images/calls/voice_bg_image.png',
              fit: BoxFit.cover,
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                // Top bar
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Row(
                    children: const [
                      BackButton(color: Colors.black87),
                      Spacer(),
                      Icon(Icons.lock, size: 18, color: Colors.black87),
                      SizedBox(width: 6),
                      Text(
                        'End-to-End Encrypted',
                        style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),
                      Icon(Icons.person_add_alt_1,
                          size: 22, color: Colors.black87),
                    ],
                  ),
                ),

                const Spacer(),

                // Avatar
                CircleAvatar(
                  radius: 56,
                  backgroundColor: Colors.white,
                  child: ClipOval(
                    child: _buildAvatar(_avatarUrl),
                  ),
                ),
                const SizedBox(height: 16),

                // Name
                Text(
                  _displayName,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 6),

                // Call duration
                Text(
                  _elapsedText,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.black54,
                  ),
                ),

                const Spacer(),

                _VoiceBottomPanel(
                  onEnd: () {
                    _controller?.hangup();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatar(String? avatarUrl) {
    if (avatarUrl != null && avatarUrl.isNotEmpty) {
      return Image.network(
        avatarUrl,
        width: 96,
        height: 96,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => Image.asset(
          'assets/images/calls/avatar_default_img.jpeg',
          width: 96,
          height: 96,
          fit: BoxFit.cover,
        ),
      );
    }

    return Image.asset(
      'assets/images/calls/avatar_default_img.jpeg',
      width: 96,
      height: 96,
      fit: BoxFit.cover,
    );
  }
}

class _VoiceBottomPanel extends StatelessWidget {
  const _VoiceBottomPanel({required this.onEnd});

  final VoidCallback onEnd;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 210,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xFF202C33),
        borderRadius: BorderRadius.vertical(top: Radius.circular(26)),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 12),
            child: Container(
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.white30,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const _VCButton(icon: Icons.volume_up_rounded, label: 'Speaker'),
              const _VCButton(icon: Icons.videocam_rounded, label: 'Video'),
              const _VCButton(icon: Icons.mic_rounded, label: 'Mute'),
              _VCButton(
                icon: Icons.call_end_rounded,
                label: 'End',
                destructive: true,
                onTap: onEnd,
              ),
            ],
          ),
          const SizedBox(height: 24),
          const _ParticipantTile(title: 'Add Person', isAdd: true),
        ],
      ),
    );
  }
}

class _VCButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool destructive;
  final VoidCallback? onTap;

  const _VCButton({
    super.key,
    required this.icon,
    required this.label,
    this.destructive = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = destructive ? Colors.red : const Color(0xFF1F2C34);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(26),
      child: Column(
        children: [
          CircleAvatar(
            radius: 26,
            backgroundColor: bgColor,
            child: Icon(icon, color: Colors.white),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: const TextStyle(color: Colors.white70, fontSize: 11),
          ),
        ],
      ),
    );
  }
}

class _ParticipantTile extends StatelessWidget {
  final String title;
  final String? avatarUrl;
  final bool isAdd;

  const _ParticipantTile({
    super.key,
    required this.title,
    this.avatarUrl,
    this.isAdd = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: isAdd ? const Color(0xFF00A884) : Colors.white24,
        child: isAdd
            ? const Icon(Icons.person_add_alt_1, color: Colors.white)
            : ClipOval(
                child: (avatarUrl != null && avatarUrl!.isNotEmpty)
                    ? Image.network(
                        avatarUrl!,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Image.asset(
                          'assets/images/calls/avatar_default_img.jpeg',
                        ),
                      )
                    : Image.asset(
                        'assets/images/calls/avatar_default_img.jpeg',
                        fit: BoxFit.cover,
                      ),
              ),
      ),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}

/// Simple manual ticker (1-second interval) – no TickerProvider needed.
class Ticker {
  Ticker(this.onTick);

  final void Function(Duration) onTick;
  Duration _elapsed = Duration.zero;
  bool _running = false;
  late final Stopwatch _stopwatch;

  void start() {
    if (_running) return;
    _running = true;
    _stopwatch = Stopwatch()..start();
    _tick();
  }

  Future<void> _tick() async {
    while (_running) {
      await Future<void>.delayed(const Duration(seconds: 1));
      _elapsed = _stopwatch.elapsed;
      onTick(_elapsed);
    }
  }

  void dispose() {
    _running = false;
  }
}
