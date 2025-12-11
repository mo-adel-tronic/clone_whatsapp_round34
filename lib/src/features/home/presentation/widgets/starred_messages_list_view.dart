import 'package:flutter/material.dart';
import '../../domain/entities/starred_message_entity.dart';

class StarredMessagesListView extends StatelessWidget {
  final List<StarredMessageEntity> messages;
  final void Function(StarredMessageEntity) onUnstar;


  const StarredMessagesListView({super.key, required this.messages,    required this.onUnstar,
});

  @override
  Widget build(BuildContext context) {

    return ListView.separated(
      itemCount: messages.length,
      separatorBuilder: (context, index) => Divider(
        height: 1,
        color: Colors.grey.shade200,
        indent: 70,
      ),
      itemBuilder: (context, index) {
        final message = messages[index];
        return ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          leading: CircleAvatar(
            radius: 24,
            backgroundColor: Colors.grey.shade300,
            child: const Icon(Icons.person, color: Colors.white, size: 30),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                message.senderName,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 2),
              Text(
                message.messageContent,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.grey[600], fontSize: 14),
              ),
            ],
          ),
          trailing: Text(
            message.date,
            style: const TextStyle(color: Colors.grey, fontSize: 12),
          ),
          
          // navigate to message
          onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Navigate to message in chat')));
          },

          // hanlde unstar of 1 message
          onLongPress: () {

            onUnstar(message);
          }
        );
      },
    );
  }
}
