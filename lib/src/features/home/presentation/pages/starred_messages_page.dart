import 'package:clone_whatsapp_round34/src/features/home/data/sources/source_starred_message.dart';
import 'package:clone_whatsapp_round34/src/features/home/presentation/widgets/starred_messages_empty_view.dart';
import 'package:clone_whatsapp_round34/src/features/home/presentation/widgets/starred_messages_list_view.dart';
import 'package:flutter/material.dart';
import '../../domain/entities/starred_message_entity.dart';

class StarredMessagesPage extends StatefulWidget {
  const StarredMessagesPage({super.key});

  @override
  State<StarredMessagesPage> createState() => _StarredMessagesPageState();
}

class _StarredMessagesPageState extends State<StarredMessagesPage> {
  List<StarredMessageEntity> starredMessages = [];

  bool isSearching = false;
  String searchText = "";
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    starredMessages = List.from(dummyStarredMessages);
  }

  List<StarredMessageEntity> get filteredMessages {
    if (searchText.isEmpty) return starredMessages;

    return starredMessages.where((msg) {
      final query = searchText.toLowerCase();
      return msg.senderName.toLowerCase().contains(query) ||
          msg.messageContent.toLowerCase().contains(query);
    }).toList();
  }

  // Unstar ALL messages
  void unstarAll() {
    setState(() {
      starredMessages.clear();
    });
  }

  // Unstar a SINGLE message
  void unstarMessage(StarredMessageEntity msg) {
    setState(() {
      starredMessages.remove(msg);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: !isSearching
            ? const Text("Starred Messages")
            : TextField(
                controller: searchController,
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: "Search messages...",
                  border: InputBorder.none,
                ),
                onChanged: (value) {
                  setState(() => searchText = value);
                },
              ),
        actions: [
      
          IconButton(
            icon: Icon(isSearching ? Icons.close : Icons.search),
            onPressed: () {
              setState(() {
                if (isSearching) {
                  searchController.clear();
                  searchText = "";
                }
                isSearching = !isSearching;
              });
            },
          ),

          // Menu
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == "unstar") {
                unstarAll();
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: "unstar",
                child: Text("Unstar all"),
              ),
            ],
          ),
        ],
      ),

      // BODY
      body: filteredMessages.isEmpty
          ? const StarredMessagesEmptyView()
          : StarredMessagesListView(
              messages: filteredMessages,
              onUnstar: unstarMessage,
            ),
    );
  }
}
