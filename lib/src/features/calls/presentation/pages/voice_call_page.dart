import 'package:flutter/material.dart';
import 'package:clone_whatsapp_round34/src/features/calls/data/models/call_model.dart';

class VoiceCallPage extends StatefulWidget {
  const VoiceCallPage({super.key});

  @override
  State<VoiceCallPage> createState() => _VoiceCallPageState();
}

class _VoiceCallPageState extends State<VoiceCallPage> {
  bool _isPanelExpanded = false;

  double get _collapsedHeight => 210;
  double get _expandedHeight => 300;

  void _togglePanel() {
    setState(() {
      _isPanelExpanded = !_isPanelExpanded;
    });
  }

  CallModel? _call;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Read CallModel once (safely)
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is CallModel) {
      _call = args;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Use data from CallModel when available, otherwise safe defaults
    final String displayName = _call?.name ?? 'Unknown contact';
    final String displayDuration = _call?.timeLabel ?? '00:00';
    final String? avatarUrl = _call?.avatarUrl;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // 1) Wallpaper background (full screen)
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/calls/wa_wallpaper.jpg'),
                  fit: BoxFit.cover,
                  opacity: 0.4,
                ),
              ),
            ),
          ),

          // 2) Top bar: back + lock + text + add person
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Row(
                children: const [
                  BackButton(color: Colors.white),
                  // SizedBox(width: 4),
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
                  Icon(
                    Icons.person_add_alt_1_outlined,
                    color: Colors.white,
                    size: 22,
                  ),
                ],
              ),
            ),
          ),

          // 3) Center avatar + name + duration
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 120),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  //Avatar
                  _MainAvatar(
                    avatarUrl: avatarUrl,
                    size: 52,
                  ),
                  const SizedBox(height: 16),

                  //Name
                  Text(
                    displayName,
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 6),

                  //Duration(should be count the real min,sec)
                  Text(
                    displayDuration,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 4) Bottom sheet: dark panel + controls + participants
          Align(
            alignment: Alignment.bottomCenter,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              curve: Curves.easeInOut,
              height: _isPanelExpanded ? _expandedHeight : _collapsedHeight,
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFF202C33), // WhatsApp dark call panel color
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(24),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Grab handle
                  // it wraps another widget (its child) to add interactivity to it.

                  //it display the button that we can use it to open/hide (expand or not) the pannel
                  GestureDetector(
                    onTap: _togglePanel,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 12, bottom: 10),
                      child: Container(
                        width: 40,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.white24,
                          borderRadius: BorderRadius.circular(999),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 4),

                  //Actual Data
                  // Controls row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      _VoiceControlButton(
                        icon: Icons.volume_up_rounded,
                        label: 'Speaker',
                      ),
                      _VoiceControlButton(
                        icon: Icons.videocam_rounded,
                        label: 'Video',
                      ),
                      _VoiceControlButton(
                        icon: Icons.mic_rounded,
                        label: 'Mute',
                      ),
                      _VoiceControlButton(
                        icon: Icons.call_end_rounded,
                        label: 'End',
                        isDestructive: true,
                      ),
                    ],
                  ),

                  const SizedBox(height: 18),

                  // Extra participants only when expanded
                  if (_isPanelExpanded) ...[
                    const _ParticipantTile(
                      title: 'Add Person',
                      isAddPerson: true,
                    ),
                    const SizedBox(height: 4),
                    //if (_call != null)
                    _ParticipantTile(
                      title: displayName,
                      avatarUrl: avatarUrl ??
                          'assets/images/calls/avatar_default_img.jpeg',
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

/// Center avatar – network with asset fallback
class _MainAvatar extends StatelessWidget {
  final String? avatarUrl;
  final double size;

  const _MainAvatar({
    required this.avatarUrl,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: size,
      backgroundColor: Colors.white24,
      child: ClipOval(
        child: (avatarUrl?.isNotEmpty ?? false)
          ? Image.network(
            avatarUrl!,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Image.asset(
                  'assets/images/calls/avatar_default_img.jpeg',
                  fit: BoxFit.cover,
                ),
              )
            : Image.asset(
                'assets/images/calls/avatar_default_img.jpeg',
                fit: BoxFit.cover,
              ),
      ),
    );
  }
}

/// Round control button in the bottom panel
//for Speaker , Video , Mute , End the call
class _VoiceControlButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isDestructive;

  const _VoiceControlButton({
    required this.icon,
    required this.label,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    final Color bg = isDestructive
        ? Colors.red
        : const Color(0xFF1F2C34); // slightly lighter

    return Column(
      children: [
        CircleAvatar(
          radius: 24,
          backgroundColor: bg,
          child: Icon(icon, color: Colors.white),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 11,
          ),
        ),
      ],
    );
  }
}

/// Participant tiles shown when the panel is expanded
class _ParticipantTile extends StatelessWidget {
  final String title;
  final String? avatarUrl;
  final bool isAddPerson;

  const _ParticipantTile({
    required this.title,
    this.avatarUrl,
    this.isAddPerson = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      leading: CircleAvatar(
        backgroundColor: isAddPerson ? const Color(0xFF00A884) : Colors.white10,
        child: isAddPerson
            ? const Icon(Icons.person_add_alt_1_rounded, color: Colors.white)
            : ClipOval(
                child: (avatarUrl?.isNotEmpty ?? false)
                  ? Image.network(
                    avatarUrl!,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Image.asset(
                          'assets/images/calls/avatar_default_img.jpeg',
                          fit: BoxFit.cover,
                        ),
                      )
                    : Image.asset(
                        'assets/images/calls/avatar_default_img.jpeg',
                        fit: BoxFit.cover,
                      ),
              ),
      ),
      title: //ex:Add Person
          Text(
        title,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
