import 'package:flutter/material.dart';
import '../../domain/entities/starred_message_entity.dart';

class StarredMessagesListView extends StatelessWidget {
  final List<StarredMessageEntity> messages;
  final void Function(StarredMessageEntity) onUnstar;

  const StarredMessagesListView({
    super.key,
    required this.messages,
    required this.onUnstar,
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

        return InkWell(
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Navigate to message in chat')),
            );
          },
          onLongPress: () {
            onUnstar(message);
          },

          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. AVATAR
                CircleAvatar(
                  radius: 15,
                  backgroundColor: Colors.grey.shade300,
                  child: const Icon(Icons.person, color: Colors.white, size: 15),
                ),
                
                const SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // TOP ROW: Name vs Date
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            message.senderName,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            message.date,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(8), 
                              ),
                            child: 
                          Expanded(
                            child: Text(
                              message.messageContent,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 14,
                              ),
                            ),
                          ),
                          ),
                          const SizedBox(width: 8),
                          Icon(
                            Icons.star,
                            size: 16,
                            color: Colors.grey[500],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}