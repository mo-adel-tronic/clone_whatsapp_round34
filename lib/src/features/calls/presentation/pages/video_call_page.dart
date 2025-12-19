// lib/src/features/calls/presentation/pages/video_call_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:clone_whatsapp_round34/src/features/calls/data/models/call_model.dart';
import 'package:clone_whatsapp_round34/src/features/calls/data/controller/call_controller.dart';
import 'package:clone_whatsapp_round34/src/features/calls/data/services/supabase_signaling_service.dart';
import 'package:clone_whatsapp_round34/src/features/calls/data/services/webrtc_service.dart';

class VideoCallPage extends StatefulWidget {
  const VideoCallPage({super.key});

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

  late RTCVideoRenderer _localRenderer;
  late RTCVideoRenderer _remoteRenderer;

  CallController? _controller;
  bool _logicInitialized = false;

  @override
  void initState() {
    super.initState();
    _localRenderer = RTCVideoRenderer();
    _remoteRenderer = RTCVideoRenderer();
    _localRenderer.initialize();
    _remoteRenderer.initialize();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_logicInitialized) return;

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

    _initCallLogic();
    _logicInitialized = true;
  }

  Future<void> _initCallLogic() async {
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

    // Start as caller for now
    await controller.initAsCaller(
      newCallId: callId,
      isVideoCall: true,
    );

    // Bind remote stream
    controller.remoteStreamStream.listen((stream) {
      if (!mounted) return;
      setState(() {
        _remoteRenderer.srcObject = stream;
      });
    });

    // Local stream
    setState(() {
      _localRenderer.srcObject = controller.localStream;
    });
  }

  void _togglePanel() {
    setState(() => _isPanelExpanded = !_isPanelExpanded);
  }

  @override
  void dispose() {
    _localRenderer.dispose();
    _remoteRenderer.dispose();
    _controller?.hangup();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final avatarUrl = _avatarUrl;
    final displayName = _displayName;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Remote video (or fallback image)
          Positioned.fill(
            child: _remoteRenderer.srcObject != null
                ? RTCVideoView(
                    _remoteRenderer,
                    objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
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

          // Small local preview - hidden when panel expanded
          if (!_isPanelExpanded)
            Positioned(
              right: 16,
              bottom: _collapsedHeight + 10,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: SizedBox(
                  width: 120,
                  height: 160,
                  child: _localRenderer.srcObject != null
                      ? RTCVideoView(
                          _localRenderer,
                          mirror: true,
                          objectFit:
                              RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
                        )
                      : _buildAvatarPreview(avatarUrl),
                ),
              ),
            ),

          // Bottom action sheet
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
                        onTap: () {
                          _controller?.hangup();
                          Navigator.of(context).pop();
                        },
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
