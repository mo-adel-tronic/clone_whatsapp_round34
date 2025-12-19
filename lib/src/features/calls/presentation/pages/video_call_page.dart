import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:permission_handler/permission_handler.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';

import 'package:clone_whatsapp_round34/src/features/calls/data/models/call_model.dart';
import 'package:clone_whatsapp_round34/src/features/calls/services/igora/agora_config.dart';

class VideoCallPage extends StatefulWidget {
  const VideoCallPage({super.key});

  static const String routeName = '/video-call';

  @override
  State<VideoCallPage> createState() => _VideoCallPageState();
}

class _VideoCallPageState extends State<VideoCallPage> {
  bool _isPanelExpanded = false;
  double get _collapsedHeight => 200;
  double get _expandedHeight => 320;

  late CallModel _call;
  late String _displayName;
  String? _avatarUrl;

  RtcEngine? _engine;
  String _channelId = '';
  int? _remoteUid;
  bool _joined = false;

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
        isVideoCall: true,
        isIncoming: false,
        isMissed: false,
        timeLabel: '',
      );
    }

    _displayName = _call.name ?? 'Unknown contact';
    _avatarUrl = _call.avatarUrl;

    _channelId = AgoraConfig.buildChannelId(
      _call.id ?? 'local_${DateTime.now().millisecondsSinceEpoch}',
    );

    _initAgora();
  }

  Future<void> _initAgora() async {
    // Web: UI only
    if (kIsWeb) return;

    await [
      Permission.microphone,
      Permission.camera,
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
        onUserJoined: (RtcConnection connection, int uid, int elapsed) {
          setState(() => _remoteUid = uid);
        },
        onUserOffline:
            (RtcConnection connection, int uid, UserOfflineReasonType reason) {
          setState(() => _remoteUid = null);
        },
      ),
    );

    await engine.enableVideo();
    await engine.startPreview();

    await engine.joinChannel(
      token: AgoraConfig.devToken,
      channelId: _channelId,
      uid: 0,
      options: const ChannelMediaOptions(),
    );
  }

  void _togglePanel() {
    setState(() => _isPanelExpanded = !_isPanelExpanded);
  }

  @override
  void dispose() {
    if (!kIsWeb && _engine != null) {
      _engine!.leaveChannel();
      _engine!.release();
    }
    super.dispose();
  }

  Future<void> _endCall() async {
    if (!kIsWeb && _engine != null) {
      await _engine!.leaveChannel();
    }
    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final avatarUrl = _avatarUrl;
    final displayName = _displayName;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Remote video or background image
          Positioned.fill(
            child: (!kIsWeb && _engine != null && _remoteUid != null)
                ? AgoraVideoView(
                    controller: VideoViewController.remote(
                      rtcEngine: _engine!,
                      canvas: VideoCanvas(uid: _remoteUid),
                      connection: RtcConnection(channelId: _channelId),
                    ),
                  )
                : Image.asset(
                    'assets/images/calls/video_bg_image.png',
                    fit: BoxFit.cover,
                  ),
          ),

          // Top bar
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Row(
                children: const [
                  BackButton(color: Colors.white),
                  Spacer(),
                  Icon(Icons.lock, color: Colors.white, size: 18),
                  SizedBox(width: 6),
                  Text(
                    'End-to-End Encrypted',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Spacer(),
                  Icon(Icons.person_add_alt_1, color: Colors.white, size: 22),
                ],
              ),
            ),
          ),

          // Local preview bottom-right (hidden when panel expanded)
          if (!_isPanelExpanded)
            Positioned(
              right: 16,
              bottom: _collapsedHeight + 10,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: SizedBox(
                  width: 120,
                  height: 160,
                  child: (!kIsWeb && _engine != null && _joined)
                      ? AgoraVideoView(
                          controller: VideoViewController(
                            rtcEngine: _engine!,
                            canvas: const VideoCanvas(uid: 0),
                          ),
                        )
                      : _buildAvatarPreview(avatarUrl),
                ),
              ),
            ),

          // Bottom sheet controls
          Align(
            alignment: Alignment.bottomCenter,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              height: _isPanelExpanded ? _expandedHeight : _collapsedHeight,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFF202C33),
                borderRadius: BorderRadius.vertical(top: Radius.circular(26)),
              ),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: _togglePanel,
                    child: Padding(
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
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const _VCButton(
                          icon: Icons.flip_camera_android_rounded,
                          label: 'Flip'),
                      const _VCButton(
                          icon: Icons.photo_camera_rounded, label: 'Photo'),
                      const _VCButton(
                          icon: Icons.videocam_off_rounded, label: 'Video'),
                      const _VCButton(
                          icon: Icons.mic_off_rounded, label: 'Mute'),
                      _VCButton(
                        icon: Icons.call_end_rounded,
                        label: 'End',
                        destructive: true,
                        onTap: _endCall,
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  if (_isPanelExpanded) ...[
                    const _ParticipantTile(title: 'Add Person', isAdd: true),
                    const SizedBox(height: 4),
                    _ParticipantTile(
                      title: displayName,
                      avatarUrl: avatarUrl,
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatarPreview(String? avatarUrl) {
    final hasUrl = avatarUrl != null && avatarUrl.isNotEmpty;
    if (hasUrl) {
      return Image.network(
        avatarUrl!,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => Image.asset(
          'assets/images/calls/avatar_default_img.jpeg',
          fit: BoxFit.cover,
        ),
      );
    }
    return Image.asset(
      'assets/images/calls/avatar_default_img.jpeg',
      fit: BoxFit.cover,
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
