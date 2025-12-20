import 'package:flutter/material.dart';
import 'package:clone_whatsapp_round34/src/features/calls/data/models/call_model.dart';

class VideoCallPage extends StatefulWidget {
  const VideoCallPage({super.key});

  @override
  State<VideoCallPage> createState() => _VideoCallPageState();
}

class _VideoCallPageState extends State<VideoCallPage> {
  bool _isPanelExpanded = false;

  double get _collapsedHeight => 200;
  double get _expandedHeight => 320;

  void _togglePanel() {
    setState(() => _isPanelExpanded = !_isPanelExpanded);
  }

  CallModel? call;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is CallModel) call = args;
  }

  @override
  Widget build(BuildContext context) {
    final String displayName = call?.name ?? "Unknown contact";
    final String? avatarUrl = call?.avatarUrl;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          //Backgraound image for the call (should be the caller bg image)
          Positioned.fill(
            child: Image.network(
              "https://picsum.photos/900/1600",
              //call?.bgImgUrl ?? '',
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Image.asset(
                'assets/images/calls/video_bg_image.png',
              ),
            ),
          ),

          // Top Bar
          //like voice page
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
                    "End-to-End Encrypted",
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

          // Small floating user preview bottom-right
          //Should be the sender avatar
          if (!_isPanelExpanded) //hide it when user expand the panel
            Positioned(
              right: 16,
              bottom: _isPanelExpanded
                  ? _expandedHeight + 10
                  : _collapsedHeight + 10,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: SizedBox(
                  width: 120,
                  height: 160,
                      child: (avatarUrl?.isNotEmpty ?? false)
                        ? Image.network(
                          avatarUrl!,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Image.asset(
                              "assets/images/calls/avatar_default_img.jpeg"),
                        )
                      : Image.asset(
                          "assets/images/calls/avatar_default_img.jpeg",
                          fit: BoxFit.cover,
                        ),
                ),
              ),
            ),

          // Bottom Action Sheet
          Align(
            alignment: Alignment.bottomCenter,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              height: _isPanelExpanded ? _expandedHeight : _collapsedHeight,
              width: double.infinity,

              //the bg black color that has the buttons
              decoration: const BoxDecoration(
                color: Color(0xFF202C33),
                borderRadius: BorderRadius.vertical(top: Radius.circular(26)),
              ),

              child: Column(
                children: [
                  //like voice page
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

                  // Action buttons row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      _VCButton(
                          icon: Icons.flip_camera_android_rounded,
                          label: "Flip"),
                      _VCButton(
                          icon: Icons.photo_camera_rounded, label: "Photo"),
                      _VCButton(
                          icon: Icons.videocam_off_rounded, label: "Video"),
                      _VCButton(icon: Icons.mic_off_rounded, label: "Mute"),
                      _VCButton(
                        icon: Icons.call_end_rounded,
                        label: "End",
                        destructive: true,
                      ),
                    ],
                  ),

                  const SizedBox(height: 18),

                  // Participants when expanded
                  if (_isPanelExpanded) ...[
                    const _ParticipantTile(title: "Add Person", isAdd: true),
                    const SizedBox(height: 4),
                    //if (call != null)
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
}

class _VCButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool destructive;

  const _VCButton({
    required this.icon,
    required this.label,
    this.destructive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 26,
          backgroundColor: destructive ? Colors.red : const Color(0xFF1F2C34),
          child: Icon(icon, color: Colors.white),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 11),
        )
      ],
    );
  }
}

class _ParticipantTile extends StatelessWidget {
  final String title;
  final String? avatarUrl;
  final bool isAdd;

  const _ParticipantTile({
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
                child: (avatarUrl?.isNotEmpty ?? false)
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
