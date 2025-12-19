import 'package:clone_whatsapp_round34/src/features/calls/services/igora/agora_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:permission_handler/permission_handler.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';

import 'package:clone_whatsapp_round34/src/features/calls/data/models/call_model.dart';

class VoiceCallPage extends StatefulWidget {
  const VoiceCallPage({super.key});

  static const String routeName = '/voice-call';

  @override
  State<VoiceCallPage> createState() => _VoiceCallPageState();
}

class _VoiceCallPageState extends State<VoiceCallPage> {
  late CallModel _call;
  late String _displayName;
  String? _avatarUrl;

  RtcEngine? _engine;
  String _channelId = '';
  bool _joined = false;

  Duration _elapsed = Duration.zero;
  _Ticker? _ticker;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is CallModel) {
      _call = args;
    } else {
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
    _channelId = AgoraConfig.buildChannelId(
        _call.id ?? 'local_${DateTime.now().millisecondsSinceEpoch}');

    _initAgora();
  }

  Future<void> _initAgora() async {
    // Web: UI only – just start the timer and return
    if (kIsWeb) {
      _ticker = _Ticker((elapsed) {
        if (!mounted) return;
        setState(() => _elapsed = elapsed);
      })
        ..start();
      return;
    }

    // Request permissions (Android/iOS)
    await [
      Permission.microphone,
    ].request();

    final engine = createAgoraRtcEngine();
    _engine = engine;

    await engine.initialize(const RtcEngineContext(
      appId: AgoraConfig.appId,
      channelProfile: ChannelProfileType.channelProfileCommunication,
    ));

    engine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          setState(() => _joined = true);
        },
        onLeaveChannel: (RtcConnection connection, RtcStats stats) {
          setState(() => _joined = false);
        },
      ),
    );

    await engine.enableAudio();

    await engine.joinChannel(
      token: AgoraConfig.devToken,
      channelId: _channelId,
      uid: 0, // 0 means "let Agora assign a UID"
      options: const ChannelMediaOptions(),
    );

    // Start timer
    _ticker = _Ticker((elapsed) {
      if (!mounted) return;
      setState(() => _elapsed = elapsed);
    })
      ..start();
  }

  @override
  void dispose() {
    _ticker?.dispose();
    if (!kIsWeb && _engine != null) {
      _engine!.leaveChannel();
      _engine!.release();
    }
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

                Text(
                  _joined ? _elapsedText : 'Calling…',
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.black54,
                  ),
                ),

                const Spacer(),

                _VoiceBottomPanel(
                  onEnd: () async {
                    if (!kIsWeb && _engine != null) {
                      await _engine!.leaveChannel();
                    }
                    if (mounted) Navigator.of(context).pop();
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

/// Simple 1-second ticker (no TickerProvider needed)
class _Ticker {
  _Ticker(this.onTick);

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
