import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/chat_bloc.dart';
import '../bloc/chat_event.dart';

class AttachmentsSheet extends StatelessWidget {
  const AttachmentsSheet({super.key});

  Widget _buildTile(BuildContext context, IconData icon, String title, VoidCallback onTap) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(18),
            decoration: const BoxDecoration(
              color: Colors.white10,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.white, size: 28),
          ),
        ),
        const SizedBox(height: 8),
        Text(title, style: const TextStyle(color: Colors.white)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: const BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 3,
        mainAxisSpacing: 25,
        crossAxisSpacing: 25,
        children: [
          _buildTile(context, Icons.insert_drive_file, "Document", () {
            Navigator.pop(context);
            context.read<ChatBloc>().add(OpenDocumentEvent());
          }),
          _buildTile(context, Icons.camera_alt, "Camera", () {
            Navigator.pop(context);
            context.read<ChatBloc>().add(OpenCameraEvent());
          }),
          _buildTile(context, Icons.image, "Gallery", () {
            Navigator.pop(context);
            context.read<ChatBloc>().add(OpenGalleryEvent());
          }),
          _buildTile(context, Icons.music_note, "Audio", () {
            
          }),
          _buildTile(context, Icons.location_on, "Location", () {
            Navigator.pop(context);
            context.read<ChatBloc>().add(OpenLocationEvent());
          }),
          _buildTile(context, Icons.person, "Contact", () {
           
          }),
          _buildTile(context, Icons.poll, "Poll", () {
       
          }),
        ],
      ),
    );
  }
}